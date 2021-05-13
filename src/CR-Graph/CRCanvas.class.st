Class {
	#name : #CRCanvas,
	#superclass : #CRNode,
	#instVars : [
		'nodes',
		'edges'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRCanvas class >> newFrom: someNodes edges: someEdges [
	| c |
	c := CRCanvas new .
	c setNodeGroup: someNodes.
	c setEdgeGroup: someEdges.
	^c
]

{ #category : #accessing }
CRCanvas >> addAllEdges: shapeCollection [
	edges addAll: shapeCollection.
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
CRCanvas >> canvasAsNode [
	| c |
	"c := CRNode new.
	c size: 100@100.
	c clipChildren: false.
	c addChild: self.
	^c"
	self addToolTip.
	self makeDraggable.
	self openModelOnClick.
	self graph beNode.
	self border: (BlBorder paint: Color black width: 2).
	^self
]

{ #category : #accessing }
CRCanvas >> canvasForView [
	| c |
	c := BlZoomableElement new contentElement: self.
	c clipChildren: false.
	self requestFocusOnClick: c.
	self addScrollToZoom: c.
	self jumpToInitialZoomOnSpace: c.
	^ c asPannableElement
]

{ #category : #accessing }
CRCanvas >> initialize [
	super initializeForCanvas.
	nodes := CRGroup new.
	edges := CRGroup new.
	self properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).
	self clipChildren: false.
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
	self addChildren: nodes.
	self addChildren: edges.
]

{ #category : #accessing }
CRCanvas >> requestFocusOnClick: aElement [
	aElement addEventHandlerOn: BlClickEvent do: [:e | 
		e consumed: true. 
		e currentTarget requestFocus].
]

{ #category : #accessing }
CRCanvas >> setEdgeGroup: aCRGroup [
	edges := aCRGroup
]

{ #category : #accessing }
CRCanvas >> setNodeGroup: aCRGroup [
	nodes := aCRGroup.
]
