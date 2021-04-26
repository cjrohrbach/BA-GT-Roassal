"
I hold all nodes and edges that are displayed in a graph.
"
Class {
	#name : #CRCanvas,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'layout',
		'edges',
		'nodes'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRCanvas >> addAllEdges: shapeCollection [
	edges addAll: shapeCollection.
	canvas addChildren: shapeCollection.
]

{ #category : #accessing }
CRCanvas >> addEdge: aShape [
	edges add: aShape.
]

{ #category : #accessing }
CRCanvas >> addScrollToZoom [
	| eh |
	eh := BlEventHandler new 
	action: [ :e |
		(e isScrollDown) ifTrue: [canvas zoomOut].
		(e isScrollUp) ifTrue: [canvas zoomIn].
		];
	eventClass: (BlMouseWheelEvent).
	
	canvas addEventHandler: eh.
]

{ #category : #accessing }
CRCanvas >> addScrollToZoom: aElement [
	| eh |
	eh := BlEventHandler new 
	action: [ :e |
		(e isScrollDown) ifTrue: [aElement zoomOut].
		(e isScrollUp) ifTrue: [aElement zoomIn].
		];
	eventClass: (BlMouseWheelEvent).
	
	aElement addEventHandler: eh.
]

{ #category : #accessing }
CRCanvas >> asElement [
	^canvas
]

{ #category : #accessing }
CRCanvas >> asPannableElement [
	| c |
	
	c := BlZoomableElement new contentElement: canvas.
	c clipChildren: false.
	self addScrollToZoom: c.
	^c asPannableElement
]

{ #category : #accessing }
CRCanvas >> gtCanvasViewOn: aView [
	<gtView>
	^ aView explicit 
		title: 'Canvas';
		priority: 5;
		stencil: [
			self asPannableElement].
]

{ #category : #accessing }
CRCanvas >> initialize [
	super initialize.
	edges := CRGroup new.
	canvas := BlElement new.
	canvas properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).
	canvas clipChildren: false.
]

{ #category : #accessing }
CRCanvas >> layout: aLayout [
	canvas layout: aLayout.
]

{ #category : #accessing }
CRCanvas >> nodeCount [
	^nodes size
]

{ #category : #accessing }
CRCanvas >> nodes [
	^nodes
]

{ #category : #accessing }
CRCanvas >> paint [
	self assert: [nodes notNil] description: 'You need to set the nodeGroup first'.
	canvas addChildren: nodes.
	canvas addChildren: edges
]

{ #category : #accessing }
CRCanvas >> removeAllHighlightsOnClick [
	canvas addEventHandlerOn: BlClickEvent do: [nodes removeHighlights]
]

{ #category : #accessing }
CRCanvas >> setEdgeGroup: aCRGroup [
	edges := aCRGroup.
]

{ #category : #accessing }
CRCanvas >> setNodeGroup: aCRGroup [
	nodes := aCRGroup.
]
