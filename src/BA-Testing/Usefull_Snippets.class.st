Class {
	#name : #'Usefull_Snippets',
	#superclass : #Object,
	#category : #'BA-Testing-BA-Testing'
}

{ #category : #accessing }
Usefull_Snippets >> blElementDraggableWithModelOnClick [
	<gtExample>
	|element|
	element := BlElement new	
		background: Color red;
		size: 75@75;
		addEventHandler: BlPullHandler new;
		addEventHandlerOn: BlClickEvent do: [:e | e target phlow spawnObject: 42 ].

	^element
]

{ #category : #accessing }
Usefull_Snippets >> blElementNodesWithEdgesInTree [
	<gtExample>
	| canvas p c1 c2 edge1 edge2 |
	canvas := BlElement new 
	size: 1000@1000.
	
	p := BlElement new
		background: Color blue;
		size: 75@75;
		addEventHandler: BlPullHandler new;
		zIndex: 10.
	p graph beNode.
	
	
	c1 := BlElement new				
		background: Color red;			
		size: 75@75;
		addEventHandler: BlPullHandler new;
		zIndex: 10.
	c1 graph beNode.

	c2 := BlElement new				
		background: Color green;			
		size: 75@75;
		addEventHandler: BlPullHandler new;
		zIndex: 10.
	c2 graph beNode.


	canvas addChild: p.
	canvas addChild: c1.
	canvas addChild: c2.

	edge1 := GtGraphEdge new from: p to: c1.
	p constraints graph addConnectedEdge: edge1.
	c1 constraints graph addConnectedEdge: edge1.

	edge2 := GtGraphEdge new from: p to: c2.
	p constraints graph addConnectedEdge: edge2.
	c2 constraints graph addConnectedEdge: edge2.

	canvas layout: (GtGraphTreeLayout new verticalGap: 50; horizontalGap: 20).

	canvas allChildrenBreadthFirstDo: [ :element | 
		element graph nodesAlongOutgoingEdges do: [ :child | 
			| line |
			line := BlLineElement new.
			line constraints ignoreByLayout.
			line
				zIndex: -1;
				border: (BlBorder paint: (Color gray alpha: 0.2) width: 5);
				fromAnchor: (BlElementBottomCenterAnchor element: element);
				toAnchor: (BlElementTopCenterAnchor element: child).
			canvas addChild: line ] ].

	^canvas
]

{ #category : #accessing }
Usefull_Snippets >> blElementsWithEdge [
	<gtExample>
	| canvas l e z |
	canvas := BlElement new
	size: 1000@1000.
	
	z := BlElement new
		background: Color blue;
		size: 75@75;
		addEventHandler: BlPullHandler new;
		zIndex: 10.
	
	e := BlElement new				
		background: Color red;			
		size: 75@75;
		addEventHandler: BlPullHandler new;
		relocate: 200@200;
		zIndex: 10.
	
	l := BlLineElement new
		border: (BlBorder paint: (Color black alpha: 1) width: 2);
		zIndex: -1;
		fromAnchor: (BlNearestPositionBoundsAnchor referenceElement: z relatedTo: e);
		toAnchor: (BlNearestPositionBoundsAnchor referenceElement: e relatedTo: z).
	l constraints ignoreByLayout.

	
	canvas addChild: z.
	canvas addChild: e.
	canvas addChild: l.


	^canvas
]

{ #category : #accessing }
Usefull_Snippets >> getAllPackages [
	<gtExample>
	^ RPackageOrganizer default
]
