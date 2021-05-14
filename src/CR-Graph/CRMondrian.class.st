Class {
	#name : #CRMondrian,
	#superclass : #Object,
	#instVars : [
		'edgeBuilderCollection',
		'shapeBuilderCollection',
		'layoutBuilder',
		'canvasForView'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRMondrian >> addEdgeBuilder: edgeBuilder [
	edgeBuilderCollection add: edgeBuilder.
]

{ #category : #accessing }
CRMondrian >> addEdgeFactory: edgeFactory [
	
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
	| nodes |
	
	nodes := CRGroup new.
	shapeBuilderCollection do: [ :shapeBuilder | 
		nodes addAll: (shapeBuilder createNodes).
	].
	
	^nodes
]

{ #category : #accessing }
CRMondrian >> createCanvas [
	| nodes edges canvas layout|
	nodes := self buildNodes.
	edges := self buildEdges: nodes.
	
	canvas := CRCanvas newFrom: nodes edges: edges.
	canvas paint. 
	layoutBuilder on: canvas.
	^ canvas
]

{ #category : #accessing }
CRMondrian >> edge [
	canvasForView := nil.
	^ CREdgeBuilder newWithMondrian: self
]

{ #category : #accessing }
CRMondrian >> gtCanvasViewOn: aView [
	<gtView>
	| canvas |
	(canvasForView isNil) ifTrue: [ 
		canvasForView := self createCanvas canvasForView 
	].
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
	
	layoutBuilder := CRLayoutBuilder new.
	^self
]

{ #category : #accessing }
CRMondrian >> layout [
	canvasForView := nil.
	^layoutBuilder
]

{ #category : #accessing }
CRMondrian >> nodes [
	canvasForView := nil.
	^ CRShapeBuilderBuilder newWithMondrian: self
]
