Class {
	#name : #CRMondrian,
	#superclass : #Object,
	#instVars : [
		'edgeBuilderCollection',
		'shapeBuilderCollection',
		'layoutBuilder',
		'canvasForView',
		'canvasCache',
		'actionBuilderCollection'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRMondrian >> action [
	| actionBuilder |
	canvasForView := nil.
	canvasCache := nil.
	actionBuilder := CRActionBuilder new.
	actionBuilder mondrian: self.
	^actionBuilder
]

{ #category : #accessing }
CRMondrian >> addActionBuilder: aCRActionBuilder [
	actionBuilderCollection add: aCRActionBuilder
]

{ #category : #accessing }
CRMondrian >> addActions: someNodes [
	actionBuilderCollection do: [:ab |
		ab addActionToNodes: someNodes
	]
]

{ #category : #accessing }
CRMondrian >> addEdgeBuilder: edgeBuilder [
	edgeBuilderCollection add: edgeBuilder.
]

{ #category : #accessing }
CRMondrian >> addShapeBuilder: aShapeBuilder [
	shapeBuilderCollection add: aShapeBuilder
]

{ #category : #accessing }
CRMondrian >> buildEdges: nodes [
	| edges |
	edges := CRGroup new.
	
	edgeBuilderCollection do: [ :edgeBuilder |
		edges addAll: (edgeBuilder createEdges: nodes).
	].
	
	^edges.
]

{ #category : #accessing }
CRMondrian >> buildNodes [
	| nodes allNodes result |
	
	nodes := CRBindingGroup new.
	allNodes := CRGroup new.
	shapeBuilderCollection do: [ :shapeBuilder | | shapeNodes |
		
		shapeNodes := shapeBuilder createNodes.
	
		nodes addAll: shapeNodes.
		allNodes addAll: shapeNodes.
		
		(shapeBuilder class = CRMondrianAsNode) ifTrue: [
			
			shapeNodes do: [ :sn | | subNodes |
			
				subNodes := sn nodes.
				"subNodes do: [:n | 
					n ignoredByLayout: true
				]."
		
				allNodes addAll: subNodes.
			]
		]
	].
	
	result := OrderedCollection new.
	result add: nodes.
	result add: allNodes.
	
	^result
]

{ #category : #accessing }
CRMondrian >> collectNodesOfMondrianNodes: nodes [
	| allNodes |
	allNodes := CRGroup new.
	nodes do: [ :node |
		| sn |
		sn := node model getNodes.
		sn do: [:n | n ignoredByLayout: true].
		allNodes addAll: sn.
	].
	
	^allNodes
	
]

{ #category : #accessing }
CRMondrian >> createCanvas [
	| nodes edges canvas layout|
	nodes := self buildNodes.
	edges := self buildEdges: (nodes at: 2).
	
	self addActions: (nodes at: 2).
	
	canvas := CRCanvas newFrom: (nodes at: 1) edges: edges mondrian: self.
	canvas paint. 
	layoutBuilder on: canvas.
	canvasCache := canvas.
	^ canvas
]

{ #category : #accessing }
CRMondrian >> edge [
	canvasForView := nil.
	canvasCache := nil.
	^ CREdgeBuilder newWithMondrian: self
]

{ #category : #accessing }
CRMondrian >> getNodes [
	canvasCache ifNil: [
		self createCanvas
	].
	
	^canvasCache nodes 
]

{ #category : #accessing }
CRMondrian >> gtCanvasViewOn: aView [
	<gtView>
	canvasForView := self createCanvas canvasForView.
	^ aView explicit 
		title: 'Canvas';
		priority: 5;
		stencil: [
			canvasForView];
		actionStencil: [ 
			BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons actualsize asElement;
				label: 'Zoom to fit' asRopedText;
				action: [ canvasForView zoomToFit ] ];
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomin asElement;
				label: 'Zoom In' asRopedText;
				action: [ canvasForView zoomIn ] ];
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomout asElement;
				label: 'Zoom Out' asRopedText;
				action: [ canvasForView zoomOut ] ]
]

{ #category : #accessing }
CRMondrian >> initialize [
	super initialize.
	shapeBuilderCollection := OrderedCollection new.
	edgeBuilderCollection := OrderedCollection new.
	actionBuilderCollection := OrderedCollection new.
		
	layoutBuilder := CRLayoutBuilder new.
	^self
]

{ #category : #accessing }
CRMondrian >> layout [
	canvasForView := nil.
	canvasCache := nil.
	^layoutBuilder
]

{ #category : #accessing }
CRMondrian >> nodes [
	canvasForView := nil.
	canvasCache := nil.
	^ CRShapeBuilderBuilder newWithMondrian: self
]
