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
		'nodes',
		'canvasForView'
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
	^canvas asPannableElement
]

{ #category : #accessing }
CRCanvas >> canvas: aBlElement [
	canvas := aBlElement
]

{ #category : #accessing }
CRCanvas >> canvasForView [
	^canvasForView asPannableElement
]

{ #category : #accessing }
CRCanvas >> createInteractableElement [
	canvasForView := BlZoomableElement new contentElement: canvas.
	canvasForView clipChildren: false.
	self requestFocusOnClick: canvasForView.
	self addScrollToZoom: canvasForView.
	self jumpToInitialZoomOnSpace: canvasForView.
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
	canvas := CRNode new.
	canvas properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).
	canvas clipChildren: false.
	^self
]

{ #category : #accessing }
CRCanvas >> jumpToInitialZoomOnSpace: aElement [
	aElement addShortcut: ( 
	BlShortcutWithAction new
		combination: (BlSingleKeyCombination space);
		action: [ 
			aElement zoomToFit.]).
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
	canvas addChildren: edges.

]

{ #category : #accessing }
CRCanvas >> removeAllHighlightsOnClick [
	canvas addEventHandlerOn: BlClickEvent do: [nodes removeHighlights]
]

{ #category : #accessing }
CRCanvas >> requestFocusOnClick: aElement [
	aElement addEventHandlerOn: BlClickEvent do: [:e | 
		e consumed: true. 
		e currentTarget requestFocus].
]

{ #category : #accessing }
CRCanvas >> setEdgeGroup: aCRGroup [
	edges := aCRGroup.
]

{ #category : #accessing }
CRCanvas >> setNodeGroup: aCRGroup [
	nodes := aCRGroup.
]

{ #category : #accessing }
CRCanvas >> zoomIn [
	canvas zoomIn
]

{ #category : #accessing }
CRCanvas >> zoomOut [
	canvas zoomOut
]

{ #category : #accessing }
CRCanvas >> zoomToFit [
	canvas zoomToFit
]
