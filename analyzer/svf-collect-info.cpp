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
#include <queue>
#include <iostream>
#include <fstream>

using namespace SVF;
using namespace llvm;
using namespace std;


enum struct instruction_type{
	put,
	get,
	fthread,
	other
};

struct instruction {
	instruction_type label; // "put" or "get"
	std::vector<int> points_to_set; // promises referenced by "put" or "get"
	Value *thread_func;
};

std::ostream& operator<<(std::ostream& os, const instruction& obj){
    switch (obj.label)
	{
		case instruction_type::put:
			
			os<<"put:{";
			for(auto &it:obj.points_to_set){
				os<<it<<",";
			}
			os<<"}";
			break;
		
		case instruction_type::get:
			os<<"get:{";
			for(auto &it:obj.points_to_set){
				os<<it<<",";
			}
			os<<"}";
			break;

		case instruction_type::fthread:
			os<<"new_thread:{"<<obj.thread_func->getName().str()<<"}";
			break;

		default:
			break;
	}
    return os;
}

std::unordered_map<string,std::map<int,instruction>> all_thread;


static llvm::cl::opt<std::string> InputFilename(cl::Positional,
        llvm::cl::desc("<input bitcode>"), llvm::cl::init("-"));


std::vector<int> point_to_vec(PointerAnalysis* pta, Value* val){

	std::vector<int> rtv;
    NodeID pNodeId = pta->getPAG()->getValueNode(val);

	if(pNodeId){
		const NodeBS& pts = pta->getPts(pNodeId);
		for (NodeBS::iterator ii = pts.begin(), ie = pts.end(); ii != ie; ii++) {
			rtv.push_back(*ii);
		}
	}


    return rtv;
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
		// pag->dump("pag");

		/// Create Andersen's pointer analysis
		Andersen *ander = AndersenWaveDiff::createAndersenWaveDiff(pag);

		/// ICFG
		ICFG *icfg = pag->getICFG();
		// icfg->dump("icfg");


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
				instruction_type inst_type = instruction_type::other;
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
				
				
				if (inst_type != instruction_type::other) {
					auto operand = inst->getOperand(0);

					string node_thread = node->getFun()->getValue();
					if(!all_thread.count(node_thread)){
						// thread not exists in map
						all_thread[node_thread] = {};
					}

					auto points_to = point_to_vec(ander,operand);
					
					instruction new_record;
					switch (inst_type)
					{
						case instruction_type::put:
							
							new_record.label=instruction_type::put;
							new_record.points_to_set=points_to;
							break;
						
						case instruction_type::get:
							new_record.label=instruction_type::get;
							new_record.points_to_set=points_to;
							break;

						case instruction_type::fthread:
							new_record.label=instruction_type::fthread;
							new_record.thread_func=operand;
							break;

						default:
							break;
					}

					all_thread[node_thread][node_index] = new_record;

				}
			}
		}

	std::map<int,bool> promise_status; // initially, all promises are unset (== 0)

	ICFGNode* node0 = icfg->getICFGNode(0);
	using workList=queue<const ICFGNode*>;
	std::queue<std::pair<std::string,workList>> active_threads;
	std::set<const ICFGNode*> visited;

	assert(all_thread.count("main")==1);
	active_threads.emplace("main",workList({node0}));
	// active_threads.back().second.push(node0);

	visited.insert(node0);

	bool multi_put=false;
	while (true){
		bool has_progress = false;

		int n = active_threads.size();
		for(int i=0;i<n;++i){
			auto current_thread = active_threads.front();
			active_threads.pop();

			auto &thread_name=current_thread.first;
			auto &nodes=current_thread.second;

			

			while(true){
				auto m=nodes.size();
				if(m==0){
					break;
				}
				
				bool thread_waiting=true;	//the BFS of this thread can't proceed

				for(int j=0;j<m;++j){
					const ICFGNode *i_node=nodes.front();
					nodes.pop();

					auto id=i_node->getId();
					bool blocked_here=false;
					if(all_thread[thread_name].count(id)){
						auto &record=all_thread[thread_name][id];
						switch(record.label){
							case instruction_type::put:{
								for(auto promise:record.points_to_set){
									if(promise_status[promise]==1){
										multi_put=true;
									}
									else{
										promise_status[promise]=1;
										has_progress=true;
										
									}
								}
								break;
							}
							case instruction_type::get:{
								bool can_get=true;
								for(auto promise:record.points_to_set){
									if(promise_status[promise]==0){
										can_get=false;
									}
								}
								if(can_get){
									has_progress=true;
								}
								else{
									blocked_here=true;
								}
								break;
							}
							case instruction_type::fthread:{
								has_progress=true;
								auto callee=record.thread_func;
								auto callee_name=callee->getName().str();
								assert(all_thread.count(callee_name)==1);

								ICFGNode* thread_node=icfg->getFunEntryBlockNode(svfModule->getSVFFunction(dyn_cast<Function>(callee)));
								if(visited.find(thread_node)==visited.end()){
									active_threads.emplace(callee_name,workList({thread_node}));
									// active_threads.back().second.push(thread_node);
									visited.insert(thread_node);
									break;
								}
								
							}
							default:
								break;
						}


					}
					if(blocked_here){
						nodes.push(i_node);
					}
					else{
						thread_waiting=false;
						for(auto it=i_node->OutEdgeBegin(),eit=i_node->OutEdgeEnd();it!=eit;++it){
							ICFGEdge *edge=*it;
							ICFGNode *succ_node=edge->getDstNode();
							if(visited.find(succ_node)==visited.end()){
								visited.insert(succ_node);
								nodes.push(succ_node);
							}
						}
					}
				}
				if(thread_waiting){
					break;
				}
			}

			if(!nodes.empty()){
				active_threads.push(current_thread);
			}
		}

		if(n==0){
			cout << "no deadlock detected" << endl;
			break;
		}

		if (!has_progress) { // no thread can proceed in the current round
			cout << "deadlock detected" << endl;
			break;
		}
	}
	
	if(multi_put){
		cout<<"multiple puts to one promise detected"<<endl;
	}

		
    return 0;
}

