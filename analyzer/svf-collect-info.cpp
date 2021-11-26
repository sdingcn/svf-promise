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
			}

			cout << endl;
			myfile << endl;
		}

		myfile.close();

    return 0;
}

