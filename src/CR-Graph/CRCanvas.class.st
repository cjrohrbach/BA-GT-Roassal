Class {
	#name : #CRCanvas,
	#superclass : #CRNode,
	#instVars : [
		'nodes',
		'edges',
		'mondrian'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRCanvas class >> newFrom: someNodes edges: someEdges mondrian: aMondrian [
	| c |
	c := self new .
	c setNodeGroup: someNodes.
	c setEdgeGroup: someEdges.
	c mondrian: aMondrian.
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
		(e isScrollDown) ifTrue: [aElement zoomLevel: ((aElement zoomLevel) - (aElement zoomLevel * aElement zoomStep))].
		(e isScrollUp) ifTrue: [aElement zoomLevel: ((aElement zoomLevel) + (aElement zoomLevel * aElement zoomStep))].
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
	self openMondrianOnClick.
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
CRCanvas >> getNodes [
	^nodes collectAll: [:n | n getNodes]
]

{ #category : #accessing }
CRCanvas >> initialize [
	super initializeForCanvas.
	self removeHighlightOnClick.
	nodes := CRGroup new.
	edges := CRGroup new.
	self properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).
	self clipChildren: false.
	
	self aptitude:
			(BrGlamorousWithContextMenuAptitude
				content: [ BrGlamorousSimpleContextMenuContent new
						items: {('Toggle Debug View' -> [ self toggleDebugView ])};
						yourself ]).
	
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
CRCanvas >> mondrian: aMondrian [
	mondrian := aMondrian.
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
CRCanvas >> openMondrianOnClick [
	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consumed: true.
		(e modifiers isShift) ifTrue: [ e target phlow spawnObject: self]
		ifFalse: [e target phlow spawnObject: mondrian].
	]
]

{ #category : #accessing }
CRCanvas >> paint [
	self assert: [nodes notNil] description: 'You need to set the nodeGroup first'.
	self addChildren: nodes.
	self addChildren: edges.
]

{ #category : #accessing }
CRCanvas >> removeHighlightOnClick [
	self addEventHandlerOn: BlClickEvent do: [:e |
		(e target = self) ifTrue: [nodes removeHighlights]
	]
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

{ #category : #accessing }
CRCanvas >> toggleDebugView [
	super toggleDebugView.
	nodes do: [:node |
		node toggleDebugView.
	].
	
]
