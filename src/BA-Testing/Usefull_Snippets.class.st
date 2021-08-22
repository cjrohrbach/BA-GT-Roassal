Class {
	#name : 'Usefull_Snippets',
	#superclass : 'Object',
	#category : 'BA-Testing-BA-Testing'
}

{ #category : 'accessing' }
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

{ #category : 'accessing' }
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

{ #category : 'accessing' }
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

{ #category : 'accessing' }
Usefull_Snippets >> canvasPrototype [
	<gtExample>
	| z p canv a b c |
	z := BlZoomableElement new
	border: (BlBorder paint: (Color red) width:4);
	constraintsDo: [:con |
		con horizontal matchParent.
		con vertical matchParent.
	].

p := BlPannableElement new
	border: (BlBorder paint: (Color gray) width:4).
	
canv := BlElement new
	border: (BlBorder paint: (Color pink) width: 3);
	constraintsDo: [:con |
		con horizontal fitContent.
		con vertical fitContent.
	];
	clipChildren: false;
	layout: (BlOnceLayout new layout: (BlGridLayout new
		cellSpacing: 10; columnCount: 3)).
	
a := BlElement new
	size: 50@50;
	background: Color green;
	addEventHandler: BlPullHandler new .

b := BlElement new
	size: 50@50;
	background: Color blue;
	addEventHandler: BlPullHandler new.

c := BlElement new
	size: 50@50;
	background: Color red;
	addEventHandler: BlPullHandler new.		
	
canv addChild: a.
canv addChild: b.
canv addChild: c.

p addChild: canv.

z contentElement: (p).
^z zoomToFit
]

{ #category : 'accessing' }
Usefull_Snippets >> classBlueprintLayout [
<gtExample>
| con1 con2 con3 con4 con5 methods class slots cp |
	con1 := CRGroup new name: 'con1'.
con1 addAll: (CRMondrian methods).
con2 := CRGroup new name: 'con2'.
con2 addAll: (CRMondrian methods).
con3 := CRGroup new name: 'con3'.
con3 addAll: (CRMondrian methods).
con4 := CRGroup new name: 'con4'.
con4 addAll: (CRMondrian methods).

class := {CRShapeBuilder}.

con5 := CRShapeBuilder slots.

methods := (CRClassBlueprintBuilder new sortMethods: CRShapeBuilder methods).
slots := {con5}.

cp := CRMondrian new.
cp nodes 
	label 
		constraintsBlock: ([:constraint | 
			constraint grid horizontal span: 5.
			constraint grid horizontal alignCenter.]); 
		with: class.
cp nodes
	mondrianNodes
		toolTip: #name;
		stencil: [ :con | | mon |
			mon := CRMondrian new.
			mon nodes box toolTip: #name; with: con.
			mon
		]; with: methods.
cp nodes
	mondrianNodes
		stencil: [:con | | mon |
			mon := CRMondrian new.
			mon nodes box toolTip: #name; with: con.
			mon
		
		]; with: slots.
		

cp layout custom: (BlGridLayout new columnCount: 5; cellSpacing: 20).		
^cp 
]

{ #category : 'accessing' }
Usefull_Snippets >> getAllPackages [
	<gtExample>
	^ RPackageOrganizer default
]

{ #category : 'accessing' }
Usefull_Snippets >> mindMapCircleLayout [
<gtExample>
| c a m b |

	"c := BlElement new
		constraintsDo: [ :co |
			co horizontal matchParent.
			co vertical matchParent];
		border: (BlBorder paint: (Color blue) width: 4);
		layout: BlFrameLayout new."
	
	a := BlElement new
		border: (BlBorder paint: (Color green) width: 2);
		size: 300@300;
		layout: BlFrameLayout new.
	
	m := CRMondrian new.
	m nodes with: (1 to: 10).
	m layout circle.



	b := BlElement new
		size: 30@100;
		background: Color red.
	
	b constraints frame horizontal alignCenter.
	b constraints frame vertical alignCenter.

	a addChild: b.
	a addChild: (m createCanvas canvasForView).
	^a
]
