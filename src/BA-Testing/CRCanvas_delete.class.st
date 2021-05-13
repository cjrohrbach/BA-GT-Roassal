"
I hold all nodes and edges that are displayed in a graph.
"
Class {
	#name : #'CRCanvas_delete',
	#superclass : #Object,
	#instVars : [
		'canvas',
		'layout',
		'edges',
		'nodes',
		'canvasForView'
	],
	#category : #'BA-Testing-CR-Graph'
}

{ #category : #accessing }
CRCanvas_delete >> addAllEdges: shapeCollection [
	edges addAll: shapeCollection.
	canvas addChildren: shapeCollection.
]

{ #category : #accessing }
CRCanvas_delete >> addEdge: aShape [
	edges add: aShape.
]

{ #category : #accessing }
CRCanvas_delete >> addScrollToZoom: aElement [
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
CRCanvas_delete >> asElement [
	^canvas
]

{ #category : #accessing }
CRCanvas_delete >> asPannableElement [
	^canvas asPannableElement
]

{ #category : #accessing }
CRCanvas_delete >> canvas: aBlElement [
	canvas := aBlElement
]

{ #category : #accessing }
CRCanvas_delete >> canvasForView [
	^canvasForView asPannableElement
]

{ #category : #accessing }
CRCanvas_delete >> createInteractableElement [
	canvasForView := BlZoomableElement new contentElement: canvas.
	canvasForView clipChildren: false.
	self requestFocusOnClick: canvasForView.
	self addScrollToZoom: canvasForView.
	self jumpToInitialZoomOnSpace: canvasForView.
]

{ #category : #accessing }
CRCanvas_delete >> gtCanvasViewOn: aView [
	<gtView>
	^ aView explicit 
		title: 'Canvas';
		priority: 5;
		stencil: [
			self asPannableElement].
]

{ #category : #accessing }
CRCanvas_delete >> initialize [
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
CRCanvas_delete >> jumpToInitialZoomOnSpace: aElement [
	aElement addShortcut: ( 
	BlShortcutWithAction new
		combination: (BlSingleKeyCombination space);
		action: [ 
			aElement zoomToFit.]).
]

{ #category : #accessing }
CRCanvas_delete >> layout: aLayout [
	canvas layout: aLayout.
]

{ #category : #accessing }
CRCanvas_delete >> nodeCount [
	^nodes size
]

{ #category : #accessing }
CRCanvas_delete >> nodes [
	^nodes
]

{ #category : #accessing }
CRCanvas_delete >> paint [
	self assert: [nodes notNil] description: 'You need to set the nodeGroup first'.
	
	canvas addChildren: nodes.
	canvas addChildren: edges.

]

{ #category : #accessing }
CRCanvas_delete >> removeAllHighlightsOnClick [
	canvas addEventHandlerOn: BlClickEvent do: [nodes removeHighlights]
]

{ #category : #accessing }
CRCanvas_delete >> requestFocusOnClick: aElement [
	aElement addEventHandlerOn: BlClickEvent do: [:e | 
		e consumed: true. 
		e currentTarget requestFocus].
]

{ #category : #accessing }
CRCanvas_delete >> setEdgeGroup: aCRGroup [
	edges := aCRGroup.
]

{ #category : #accessing }
CRCanvas_delete >> setNodeGroup: aCRGroup [
	nodes := aCRGroup.
]

{ #category : #accessing }
CRCanvas_delete >> zoomIn [
	canvas zoomIn
]

{ #category : #accessing }
CRCanvas_delete >> zoomOut [
	canvas zoomOut
]

{ #category : #accessing }
CRCanvas_delete >> zoomToFit [
	canvas zoomToFit
]
