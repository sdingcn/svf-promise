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


using namespace SVF;
using namespace llvm;
using namespace std;

static llvm::cl::opt<std::string> InputFilename(cl::Positional,
        llvm::cl::desc("<input bitcode>"), llvm::cl::init("-"));

static llvm::cl::opt<bool> LEAKCHECKER("leak", llvm::cl::init(false),
                                       llvm::cl::desc("Memory Leak Detection"));

/*!
 * An example to query alias results of two LLVM values
 */
AliasResult aliasQuery(PointerAnalysis* pta, Value* v1, Value* v2){
	return pta->alias(v1,v2);
}

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


/*!
 * An example to query/collect all successor nodes from a ICFGNode (iNode) along control-flow graph (ICFG)
 */
void traverseOnICFG(ICFG* icfg, const Instruction* inst){
	ICFGNode* iNode = icfg->getBlockICFGNode(inst);
	FIFOWorkList<const ICFGNode*> worklist;
	std::set<const ICFGNode*> visited;
	worklist.push(iNode);

	/// Traverse along VFG
	while (!worklist.empty()) {
		const ICFGNode* vNode = worklist.pop();
		for (ICFGNode::const_iterator it = vNode->OutEdgeBegin(), eit =
				vNode->OutEdgeEnd(); it != eit; ++it) {
			ICFGEdge* edge = *it;
			ICFGNode* succNode = edge->getDstNode();
			if (visited.find(succNode) == visited.end()) {
				visited.insert(succNode);
				worklist.push(succNode);
			}
		}
	}
}

/*!
 * An example to query/collect all the uses of a definition of a value along value-flow graph (VFG)
 */
void traverseOnVFG(const SVFG* vfg, Value* val){
	PAG* pag = PAG::getPAG();

    PAGNode* pNode = pag->getPAGNode(pag->getValueNode(val));
    const VFGNode* vNode = vfg->getDefSVFGNode(pNode);
    FIFOWorkList<const VFGNode*> worklist;
    std::set<const VFGNode*> visited;
    worklist.push(vNode);

	/// Traverse along VFG
	while (!worklist.empty()) {
		const VFGNode* vNode = worklist.pop();
		for (VFGNode::const_iterator it = vNode->OutEdgeBegin(), eit =
				vNode->OutEdgeEnd(); it != eit; ++it) {
			VFGEdge* edge = *it;
			VFGNode* succNode = edge->getDstNode();
			if (visited.find(succNode) == visited.end()) {
				visited.insert(succNode);
				worklist.push(succNode);
			}
		}
	}

    /// Collect all LLVM Values
    for(std::set<const VFGNode*>::const_iterator it = visited.begin(), eit = visited.end(); it!=eit; ++it){
    	const VFGNode* node = *it;
    //SVFUtil::outs() << *node << "\n";
        /// can only query VFGNode involving top-level pointers (starting with % or @ in LLVM IR)
        //if(!SVFUtil::isa<MRSVFGNode>(node)){
        //    const PAGNode* pNode = vfg->getLHSTopLevPtr(node);
        //    const Value* val = pNode->getValue();
        //}
    }
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
		
		/// Query aliases
		/// aliasQuery(ander,value1,value2);

		/// Print points-to information
		/// printPts(ander, value1);

		/// Call Graph
		PTACallGraph *callgraph = ander->getPTACallGraph();
		callgraph->dump("callgraph");

		/// ICFG
		ICFG *icfg = pag->getICFG();
		icfg->dump("icfg");


		// traverse ICFG
		// for(auto it = icfg->begin(); it != icfg->end(); it++){
		int node_index = 1;
		int count = icfg->getTotalNodeNum() - 1;
		printf("total num of nodes: %d \n",count);
		while(count > 0){
			if(icfg->hasICFGNode(node_index)){
				ICFGNode* node = icfg->getICFGNode(node_index);
				// ICFGNode* node = icfg->getICFGNode(it->first);

				if(node->getNodeKind() == SVF::ICFGNode::ICFGNodeK::FunCallBlock){

					const Instruction* inst = ((CallBlockNode*) node)->getCallSite();
					string str;
					llvm::raw_string_ostream(str) << *inst;

					string put = "put";
					string get = "get";
					if ((str.find(put) != std::string::npos) || (str.find(get) != std::string::npos)) {
						cout << "node string: " << node->toString() << endl;
						auto operand = inst->getOperand(0);
						cout << "operand name:" << operand->getName().str() << endl;
						operand->print(errs());
						printf("\n");
						cout << printPts(ander,operand) << endl;
						printf("\n");
					}
				}
				node_index++;
				count--;
			}

		}


		// int index_count = 7;
		// int index_array[index_count] = {6,8,15,16,27,28,22};
		// for(int j=0; j<index_count; j++){
		// 	int node_index = index_array[j];
		// 	if(icfg->hasICFGNode(node_index)){
		// 		ICFGNode* node_ten = icfg->getICFGNode(node_index);
		// 		cout << "node string: " << node_ten->toString() << endl;

		// 		const SVFFunction* node_ten_fun = node_ten->getFun();
		// 		cout << "Belongs to function: " << node_ten_fun->getValue() << endl;

		// 		const Instruction* node_ten_inst = ((CallBlockNode*) node_ten)->getCallSite(); 
				// node_ten_inst->print(errs());
		// 		cout << endl;

		// 		int operandnum = node_ten_inst->getNumOperands();
		// 		for(int i=0; i<1; i++){
		// 			auto operand = node_ten_inst->getOperand(i);

		// 			cout << "operand name:" << operand->getName().str() << endl;

		// 			int o_uses = operand->getNumUses();
		// 			cout << "this value used times: " << o_uses << endl;

		// 			auto o_type = operand->getType();

		// 			operand->print(errs());
		// 			printf("\n");

		// 			cout << "points to information " << printPts(ander,operand) << endl;

		// 			printf("\n \n");
		// 		}
		// 	}
		// }

		// /// Value-Flow Graph (VFG)
		// VFG *vfg = new VFG(callgraph);
		// vfg->dump("vfg");

		// /// Sparse value-flow graph (SVFG)
		// SVFGBuilder svfBuilder;
		// SVFG *svfg = svfBuilder.buildFullSVFGWithoutOPT(ander);
		// svfg->dump("svfg");

		// /// Collect uses of an LLVM Value
		// // traverseOnVFG(svfg, value);

		// /// Collect all successor nodes on ICFG
		// /// traverseOnICFG(icfg, value);
		
		// LeakChecker *saber = new LeakChecker(); // if no checker is specified, we use leak checker as the default one.
		// saber->runOnModule(svfModule);
	

		// LLVMModuleSet::getLLVMModuleSet()->dumpModulesToFile(".svf.bc");

    return 0;
}

