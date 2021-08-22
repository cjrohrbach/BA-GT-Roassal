Class {
	#name : 'Presentation_2',
	#superclass : 'Object',
	#category : 'BA-Testing-Presentation'
}

{ #category : 'accessing' }
Presentation_2 >> a_basicTree [
<gtExample>		
| m | 
	m := CRMondrian new.
	m nodes with: (1 to: 10).
	m edges connectFrom: [:x | x //2].
	m layout tree.
	^m
]

{ #category : 'accessing' }
Presentation_2 >> b_multipleScopes [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes with: (1 to:4).
	m nodes label with: (5 to: 9).
	^m
]

{ #category : 'accessing' }
Presentation_2 >> c_action [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes circle borderWidth: 0.4; with: (1 to: 100).
	m action primeSieve.
	^m
]

{ #category : 'accessing' }
Presentation_2 >> d_nestedNodes [
<gtExample>
	| q |
	q := CRMondrian new.
	q nodes 
		mondrianNodes
		toolTip: #name;
		noHighlights;
		stencil: 
		[ :p | | m |
			m := CRMondrian new .
			m nodes 
				box
				toolTip: #name; 
				with: (p methods ).
			m];
		with: ( (RPackageOrganizer default packageNamed: 'CR-Graph') classes ).
	^q
]

{ #category : 'accessing' }
Presentation_2 >> e_classBlueprint [
	<gtExample>
	| classes |
	classes := OrderedCollection new.
	classes addAll: (CRShapeBuilder subclasses).
	classes add: CRShapeBuilder. 
	^CRMondrian new classBlueprintFor: classes
]

{ #category : 'accessing' }
Presentation_2 >> f_mondrianAsMindmap [
"CRMondrian as Mindmap"
	<gtExample>
	^CRMondrian new createMindMap: self createMindMapStructure
]

{ #category : 'accessing' }
Presentation_2 >> zz_createMindMapStructure [
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
	
	^s
]
