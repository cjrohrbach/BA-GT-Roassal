"
I am a Mondrian instance. I can be used to create different visualisations of data sets.
"
Class {
	#name : #CRMondrian,
	#superclass : #Object,
	#instVars : [
		'edgeBuilderCollection',
		'shapeBuilderCollection',
		'layoutBuilder',
		'canvasForView',
		'canvasCache',
		'actionBuilderCollection',
		'canvasType',
		'modelForCanvas',
		'nodeCache'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRMondrian >> action [
"
	I return a new Action builder. 
	The canvas cache gets deleted
"
	| actionBuilder |
	canvasForView := nil.
	canvasCache := nil.
	actionBuilder := CRActionBuilder new.
	actionBuilder mondrian: self.
	^actionBuilder
]

{ #category : #accessing }
CRMondrian >> addActionBuilder: aCRActionBuilder [
"I add the given CRActionBuilder to the actionBuilderCollection"
	actionBuilderCollection add: aCRActionBuilder
]

{ #category : #accessing }
CRMondrian >> addActions: someNodes [
"Add all the actions to all nodes"
	actionBuilderCollection do: [:ab |
		ab addActionToNodes: someNodes
	]
]

{ #category : #accessing }
CRMondrian >> addEdgeBuilder: edgeBuilder [
"I add the given CREdgeBuilder to the edgeBuilderCollection"
	edgeBuilderCollection add: edgeBuilder.
]

{ #category : #accessing }
CRMondrian >> addShapeBuilder: aShapeBuilder [
"I add the given CRShapeBuilder to the shapeBuilderCollection"
	shapeBuilderCollection add: aShapeBuilder
]

{ #category : #accessing }
CRMondrian >> buildEdges: nodes [
"I delegate the creation of all edges for all edgeBuilders"
	| edges allNodes |
	edges := CRGroup new.
	
	
	edgeBuilderCollection do: [ :edgeBuilder |
		edges addAll: (edgeBuilder createEdges: nodes).
	].
	
	^edges.
]

{ #category : #accessing }
CRMondrian >> buildNodes [
"
	I delegate the creation of all nodes for all shapeBuilders.
	I return an OrderedCollection containing the nodes that belong directly to this mondrian
	at position 1 and the all the nodes (including the ones within nodes) at position 2
"

	| nodes allNodes result |
	
	nodes := CRBindingGroup new.
	allNodes := CRGroup new.
	shapeBuilderCollection do: [ :shapeBuilder | | shapeNodes |
		
		shapeNodes := shapeBuilder createNodes.
	
		nodes addAll: shapeNodes.
	
		shapeNodes do: [:n |
			allNodes add: n.		
			n allChildrenDepthFirstDo: [:x | (x class = CRNode_2) ifTrue: [allNodes add: x]].
		].
	].
	
	result := OrderedCollection new.
	result add: nodes.
	result add: allNodes.
	
	nodeCache := result.
	
	^result
]

{ #category : #accessing }
CRMondrian >> classicCanvas [
"I set the Canvas type to the normal CRCanvas"
	canvasType := CRCanvas
]

{ #category : #accessing }
CRMondrian >> createCanvas [
"
	I am responsible for creating the canvas.
	Therefore I create the nodes, edges add the actions,
	the layout and then return the created canvas and 
	store it in the canvasCache.	
"
	| nodes edges canvas layout|
	nodes := self buildNodes.
	edges := self buildEdges: (nodes at: 2).
	
	self addActions: (nodes at: 2).
	
	canvas := canvasType newFrom: (nodes at: 1) edges: edges mondrian: self.
	
	modelForCanvas ifNotNil: [canvas model: modelForCanvas].
	
	canvas paint. 
	
	canvasCache := canvas.
	layoutBuilder on: canvas.
	
	^ canvas
]

{ #category : #accessing }
CRMondrian >> createMindMap: mindMapStructure [

	self nodes label text: #model; with: (mindMapStructure allNodesAsCollection).
	self edges sigmoid; connectFrom: #parent.
	self layout custom:  (GtGraphHorizontalTreeLayout new).
	^self
	
]

{ #category : #accessing }
CRMondrian >> edge [
	self deprecated: 'This method is deprecated. Use edges instead'
]

{ #category : #accessing }
CRMondrian >> edges [
"
	I return a new CREdgeBuilder.
	Since this changes the canvas the cache is deleted.
"
	canvasForView := nil.
	canvasCache := nil.
	^ CREdgeBuilder newWithMondrian: self
]

{ #category : #accessing }
CRMondrian >> getNodes [
"
	I return the nodes contained in this mondrian.
	If the canvas and therefore the nodes aren't created yet, I'll create them.
"
	canvasCache ifNil: [
		self createCanvas
	].
	
	^canvasCache nodes 
]

{ #category : #accessing }
CRMondrian >> gtCanvasViewOn: aView [
"
	I am responsible for the presentation of the canvas.
"
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

{ #category : #initialization }
CRMondrian >> initialize [
	super initialize.
	shapeBuilderCollection := OrderedCollection new.
	edgeBuilderCollection := OrderedCollection new.
	actionBuilderCollection := OrderedCollection new.
		
	layoutBuilder := CRLayoutBuilder new.
	
	self classicCanvas.
	^self
]

{ #category : #accessing }
CRMondrian >> layout [
"
	I return a new CRLayoutBuilder.
	Since this changes the canvas I delete the cache.
"
	canvasForView := nil.
	canvasCache := nil.
	^layoutBuilder
]

{ #category : #accessing }
CRMondrian >> model: aObject [
"I am a setter method for the model that should be passed on to the canvas"
	modelForCanvas := aObject.
	
]

{ #category : #accessing }
CRMondrian >> noHighlights [
"I remove all interaction highlights from nodes and edges"
	edgeBuilderCollection do: [:eb | eb noHighlights].
	shapeBuilderCollection do: [:sb | sb noHighlights].
	
]

{ #category : #accessing }
CRMondrian >> noHighlightsOnInteraction [
"I remove all interaction highlights from nodes and edges"
]

{ #category : #accessing }
CRMondrian >> nodes [
"
	I return a new CRShapeBuilderBuilder.
	Since this changes the canvas I delete the cache.
"
	canvasForView := nil.
	canvasCache := nil.
	^ CRShapeBuilderBuilder newWithMondrian: self
]
