Class {
	#name : #MindMapExamples,
	#superclass : #Object,
	#category : #'CR-Graph-MindMap'
}

{ #category : #accessing }
MindMapExamples >> hospitalManagement [
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
