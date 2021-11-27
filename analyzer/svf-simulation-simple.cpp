//===- svf-ex.cpp -- A driver example of SVF-------------------------------------//
//
//                     SVF: Static Value-Flow Analysis
//
// Copyright (C) <2013->  <Yulei Sui>
//

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//===-----------------------------------------------------------------------===//

/*
 // A driver program of SVF including usages of SVF APIs
 //
 // Author: Yulei Sui,
 */

#include "SVF-FE/LLVMUtil.h"
#include "Graphs/SVFG.h"
#include "WPA/Andersen.h"
#include "SABER/LeakChecker.h"
#include "SVF-FE/PAGBuilder.h"
#include <unordered_map>
#include <vector>
#include <iostream>
#include <fstream>
#include <queue>

using namespace SVF;
using namespace llvm;
using namespace std;

std::unordered_map<string,std::map<int,string>> all_thread;

enum instruction_type{
	put,
	get,
	fthread,
	other
};

struct instruction {
	string thread_name;
	string label;
	set<int> points_to_set; // promises referenced by "put" or "get"
	string new_thread_id; // if instruction is creating a new thread

	inline instruction operator=(instruction a) {
        label = a.label;
        points_to_set = a.points_to_set;
		new_thread_id = a.new_thread_id;
        return a;
    }
};

typedef std::queue<instruction> thread_body; // the thread_body for each thread
thread_body main_thread_body;
std::unordered_map<string,thread_body> thread_name_to_body;


static llvm::cl::opt<std::string> InputFilename(cl::Positional,
        llvm::cl::desc("<input bitcode>"), llvm::cl::init("-"));

static llvm::cl::opt<bool> LEAKCHECKER("leak", llvm::cl::init(false),
                                       llvm::cl::desc("Memory Leak Detection"));

/*!
 * An example to print points-to set of an LLVM value
 */
std::string printPts(PointerAnalysis* pta, Value* val){

    std::string str;
    raw_string_ostream rawstr(str);

    NodeID pNodeId = pta->getPAG()->getValueNode(val);

	if(pNodeId){
		printf("pag node id is: %d. Points-to information is: \n", pNodeId);

		const NodeBS& pts = pta->getPts(pNodeId);
		for (NodeBS::iterator ii = pts.begin(), ie = pts.end(); ii != ie; ii++) {
			rawstr << " " << *ii << " ";
			// PAGNode* targetObj = pta->getPAG()->getPAGNode(*ii);
			// if(targetObj->hasValue()){
			// 	rawstr << "(" <<*targetObj->getValue() << ")\t ";
			// }
		}
	}


    return rawstr.str();
}

std::string point_to_string(PointerAnalysis* pta, Value* val){

    std::string str;
    raw_string_ostream rawstr(str);

    NodeID pNodeId = pta->getPAG()->getValueNode(val);

	if(pNodeId){
		const NodeBS& pts = pta->getPts(pNodeId);
		for (NodeBS::iterator ii = pts.begin(), ie = pts.end(); ii != ie; ii++) {
			rawstr << *ii << ",";
		}
	}


    return rawstr.str();
}

int main(int argc, char ** argv) {

    int arg_num = 0;
    char **arg_value = new char*[argc];
    std::vector<std::string> moduleNameVec;
    SVFUtil::processArguments(argc, argv, arg_num, arg_value, moduleNameVec);
    cl::ParseCommandLineOptions(arg_num, arg_value,
                                "Whole Program Points-to Analysis\n");

    SVFModule* svfModule = LLVMModuleSet::getLLVMModuleSet()->buildSVFModule(moduleNameVec);
    svfModule->buildSymbolTableInfo();
    
	/// Build Program Assignment Graph (PAG)
		PAGBuilder builder;
		PAG *pag = builder.build(svfModule);
		pag->dump("pag");

		/// Create Andersen's pointer analysis
		Andersen *ander = AndersenWaveDiff::createAndersenWaveDiff(pag);

		/// ICFG
		ICFG *icfg = pag->getICFG();
		icfg->dump("icfg");


		// traverse ICFG
		for(auto it = icfg->begin(); it != icfg->end(); it++){
			int node_index = it->first;
			ICFGNode* node = icfg->getICFGNode(node_index);

			if(node->getNodeKind() == SVF::ICFGNode::ICFGNodeK::FunCallBlock){

				const Instruction* inst = ((CallBlockNode*) node)->getCallSite();
				string str;
				llvm::raw_string_ostream(str) << *inst;

				string put = "put";
				string get = "get";
				string thread = "start_fthread";
				instruction_type inst_type = other;
				if (str.find(put) != std::string::npos)
				{
					inst_type = instruction_type::put;
				}
				else if(str.find(get) != std::string::npos){
					inst_type = instruction_type::get;
				}
				else if(str.find(thread) != std::string::npos){
					inst_type = instruction_type::fthread;
				}
				
				
				if (inst_type != other) {
					auto operand = inst->getOperand(0);

					string node_thread = node->getFun()->getValue();
					if(!all_thread.count(node_thread)){
						// thread not exists in map
						all_thread[node_thread] = std::map<int,string>();
					}

					string points_to = point_to_string(ander,operand);
					if(points_to.size() > 0){
						points_to.pop_back();
					}
					string new_record;
					switch (inst_type)
					{
						case 0:
							new_record = "put:{" + points_to + "}";
							break;
						
						case 1:
							new_record = "get:{" + points_to + "}";
							break;

						case 2:
							new_record = "new_thread:{" + operand->getName().str() + "}";
							break;

						default:
							break;
					}

					all_thread[node_thread][node_index] = new_record;

				}
			}
		}

		cout << endl;
		ofstream myfile;
  		myfile.open ("thread-info.txt");
  		
		for( auto it = all_thread.begin(); it != all_thread.end(); ++it )
		{
			string key = it->first;
			map<int,string> value = it->second;

			cout << key << ":: ";
			myfile << key << ":: ";


			for(auto jt = value.begin(); jt != value.end(); ++jt){
				int stepindex = jt->first;
				string operation = jt->second;
				cout << stepindex << "~" << operation << "; ";
				myfile << stepindex << "~" << operation << "; ";

				instruction new_inst = instruction();
				new_inst.thread_name = key;
				string delimiter1 = ":";
				size_t pos = operation.find(delimiter1);
				string instruction_label = operation.substr(0, pos);
				string instruction_argument = operation.erase(0, pos + delimiter1.length());
				instruction_argument.pop_back();
				instruction_argument.erase(0,1);

				// cout << endl << instruction_label << "~~~" << instruction_argument << endl;
				new_inst.label = instruction_label;
				if(instruction_label.find("new_thread") != std::string::npos){
					new_inst.new_thread_id = instruction_argument;
				}
				else{
					// split using ,
					string delimiter2 = ",";
					size_t pos_sub = 0;
					std::string promise_name;
					while ((pos_sub = instruction_argument.find(delimiter2)) != std::string::npos) {
						promise_name = instruction_argument.substr(0, pos_sub);
						int promise_name_int = stoi(promise_name,nullptr,10);
						new_inst.points_to_set.insert(promise_name_int);
						instruction_argument.erase(0, pos_sub + delimiter2.length());
					}
					int promise_name_int = stoi(instruction_argument,nullptr,10);
					new_inst.points_to_set.insert(promise_name_int);
				}
				if(thread_name_to_body.count(key) > 0){
					thread_name_to_body[key].push(new_inst);
				}
				else{
					thread_name_to_body[key] = thread_body();
					thread_name_to_body[key].push(new_inst);
				}

			}

			cout << endl;
			myfile << endl;
		}

		myfile.close();


		// check 1
		// for(auto it=thread_name_to_body.begin(); it != thread_name_to_body.end(); ++it){
		// 	string name = it->first;
		// 	thread_body all_inst = it->second;

		// 	cout << name << ":: ";
		// 	while(all_inst.size() > 0){
		// 		instruction i = all_inst.front();
		// 		cout << i.label << "~";
		// 		all_inst.pop();
		// 		if(i.label == "new_thread"){
		// 			cout << i.new_thread_id << endl;
		// 		}
		// 		else{
		// 			for(auto j = i.points_to_set.begin(); j != i.points_to_set.end(); j++){
		// 				cout << *j << ",";
		// 			}
		// 			cout << endl;
		// 		}
		// 	}
		// }


		// do the simulation
		cout << endl << endl;
		std::map<int,bool> promise_status; // initially, all promises are unset (== 0)
		std::queue<thread_body> active_threads;
		active_threads.push(thread_name_to_body["main"]);

		bool multiple_put = false;

		cout << "round robin simulation: " << endl;
		while (true)
		{
			bool has_progress = false;

			int n = active_threads.size();
			for(int i=0; i<n; i++){
				auto current_thread = active_threads.front();
				active_threads.pop();

				auto inst = current_thread.front();
				if(inst.label == "new_thread"){
					string new_thread_name = inst.new_thread_id;
					thread_body new_thread_body = thread_name_to_body[new_thread_name];
					active_threads.push(new_thread_body);

					// after creating new thread, can always progress
					current_thread.pop();
					has_progress = true;

				}
				else if(inst.label == "put"){
					bool can_set = false;
					for(int p:inst.points_to_set){
						if(promise_status.find(p) == promise_status.end()){
							promise_status[p] = true;
							can_set = true;
						}
						else{
							if(promise_status[p] == false){
								promise_status[p] = true;
								can_set = true;
							}
						}
					}

					if(can_set == false){
						multiple_put = true;
					}

					// put can always progress
					current_thread.pop();
					has_progress = true;

				}
				else if(inst.label == "get"){
					bool can_get = true;
					for(int p:inst.points_to_set){
						if(promise_status.count(p) == 0 || promise_status[p] == 0){
							can_get = false;
						}
					}

					// can only progress if successfully get
					if(can_get){
						current_thread.pop();
						has_progress = true;
					}
				}

				cout << inst.thread_name << ":"  << inst.label << endl;

				if (!current_thread.empty()) { // if not finished, put it back to the queue
					active_threads.push(current_thread);
				}
			}

			if (active_threads.size() == 0) { // no active thread after the current round
				cout << endl;
				if(multiple_put){
					cout << "detect possible multiple put to a single promise" << endl;
				}
				cout << "no deadlock detected" << endl;
				break;
			}
			if (!has_progress) { // no thread can proceed in the current round
				cout << endl;
				if(multiple_put){
					cout << "detect possible multiple put to a single promise" << endl;
				}
				cout << "deadlock detected" << endl;
				break;
			}

		}
		



    return 0;
}

