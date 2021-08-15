Class {
	#name : 'MindMapExamples',
	#superclass : 'Object',
	#category : 'CR-Graph-MindMapExample-MindMapExample-MindMap'
}

{ #category : 'accessing' }
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
