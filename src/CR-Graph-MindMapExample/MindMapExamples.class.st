Class {
	#name : #MindMapExamples,
	#superclass : #Object,
	#category : #'CR-Graph-MindMapExample-MindMapExample-MindMap'
}

{ #category : #accessing }
MindMapExamples >> hospitalManagement [
"This requires HMHospitalSystem to work"
	<gtExample>
	| s root |
	root := MindMapNode new
	model: HMHospitalSystem;
	addChildren: {
		MindMapNode new
			model: HMSchedule;
			addChildren: {
				MindMapNode new
					model: HMWorkingDay;
					addChildren: {
						MindMapNode new
							model: HMShift;
							addChildren: {
								MindMapNode new
									model: HMShiftConstraint;
									addChildrenFromModels: {
										HMConsecutiveNightShiftsConstraint. 
										HMNightShiftConstraint.
										HMShiftExperiencedAndInexperiencedConstraint.
										HMShiftOneDoctorConstraint.
										HMStaffConstraint.}.
							}.
					}.
			}.
		MindMapNode new
			model: HMStaffMember;
			addChildrenFromModels: {HMDoctor. HMNurse. HMStaffConstraint.}.
	
	};
	isRoot.

	s := MindMapStructure new
	setRootNode: root.
	
	^CRMondrian new createMindMap: s
]

{ #category : #accessing }
MindMapExamples >> mondrianAsMindmap [
	<gtExample>
	| root s |
	root := MindMapNode new
	model: CRMondrian;
	addChildren: {
		MindMapNode new
			model: CRCanvas;
			addChildren: {}.
		MindMapNode new
			model: CRAction;
			addChildrenFromModels: {CRPrimeSieveAction. CRRandomBackgroundAction.}.
		MindMapNode new
			model: CRNode;
			addChildren: {
				MindMapNode new
					model: 'Node-Shape';
					addChildrenFromModels: {CRBox. CRCircle. CRClassBlueprintCanvas. CRBox. 
						CRCircle. CRPoint.}.
				MindMapNode new
					model: CRShapeBuilderBuilder;
					addChildren: {
						MindMapNode new
							model: CRShapeBuilder;
							addChildrenFromModels: {
								CRBoxBuilder. 
								CRCircleBuilder. 
								CRClassBlueprintBuilder. 
								CRCustomShapeBuilder.
								CRLabelBuilder.
								CRMindMapBuilder.
								CRMondrianAsNode.
								CRPointBuilder.
								CRPreBuiltNode.}
					}
			}.
		MindMapNode new
			model: CREdgeBuilder;
			addChildren: {
				MindMapNode new
					model: CREdge;
					addChildrenFromModels: {CREdgeFrom. CREdgeTo. CREdgeFromAll. CREdgeToAll.}.
				MindMapNode new
					model: TCREdge;
					addChildrenFromModels: {CRLineElement. CRArrowElement. CRSigmoidElement.}.
			}.
		MindMapNode new
			model: CRLayoutBuilder;
			addChildren: {
				MindMapNode new
					model: TCRLayout;
					addChildrenFromModels: {CRGridLayout. CRCircleLayout. CRClusterLayout. CRCustomLayout. CRFlowLayout. CRForceLayout. CRGridLayout. CRTreeLayout.}}
	}; isRoot.
	
	s := MindMapStructure new
	setRootNode: root.
	
	^CRMondrian new createMindMap: s
		
]

{ #category : #accessing }
MindMapExamples >> simpleMindMapStructure [
<gtExample>
| root s mi |
	root := MindMapNode new
	model: 'Alphabet';
	addChildren: {
		MindMapNode new
			model: 'a';
			addChildrenFromModels: {'a1'. 'a2'. 'a3'. 'a4'}.
		MindMapNode new
			model: 'b';
			addChildrenFromModels: {'b1'. 'b2'. 'b3'. 'b4'}.
		MindMapNode new
			model: 'c';
			addChildrenFromModels: {'c1'. 'c2'. 'c3'. 'c4'}.
	
	};
	isRoot.

s := MindMapStructure new
	setRootNode: root.

	
^s	
"mi := MindMapIterator new
	mindMapStructure: s;
	createOrder."
]
