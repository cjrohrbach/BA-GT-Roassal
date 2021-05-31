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
"I create a new canvas from the given nodes, edges and the mondrian instance"
	| c |
	c := self new .
	c setNodeGroup: someNodes.
	c setEdgeGroup: someEdges.
	c mondrian: aMondrian.
	^c
]

{ #category : #accessing }
CRCanvas >> addAllEdges: shapeCollection [
"I add the content of the provided collection to the collection conatining the edges"
	edges addAll: shapeCollection.
]

{ #category : #accessing }
CRCanvas >> addEdge: aShape [
"I add the provided shape as edge"
	edges add: aShape.
]

{ #category : #accessing }
CRCanvas >> addScrollToZoom: aElement [
"I add a Eventhandler to the provided elements that eables scroll to zoom on this zoomable element"
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
"I return the canvas with all the properties of a normal node"
	| c |
	self addToolTip.
	self makeDraggable.
	self openMondrianOnClick.
	self graph beNode.
	self border: (BlBorder paint: Color black width: 2).
	^self
]

{ #category : #accessing }
CRCanvas >> canvasForView [
"I return the canvas with the properties needed to display it nicely. (i.e. scroll to zoom etc)"
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
"I return all the nodes I contain and their subnodes"
	^nodes collectAll: [:n | n getNodes]
]

{ #category : #initialization }
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
"I add an Shortcut to the element that resets the zoomlevel when the space bar is pressed"
	aElement addShortcut: ( 
	BlShortcutWithAction new
		combination: (BlSingleKeyCombination space);
		action: [ 
			aElement zoomToFit.]).
]

{ #category : #accessing }
CRCanvas >> mondrian: aMondrian [
"I am a setter method for the mondrian Instance this canvas belongs to"
	mondrian := aMondrian.
]

{ #category : #accessing }
CRCanvas >> nodeCount [
"I return the number of nodes the canvas contains"
	^nodes size
]

{ #category : #accessing }
CRCanvas >> nodes [
"I am a getter method for the nodes"
	^nodes
]

{ #category : #accessing }
CRCanvas >> openMondrianOnClick [
"
	I add an Eventhandler that opens the mondrian instance in a inspectore when the canvas is clicked on.
	If the shift key is pressed while clicking the canvas itself is opend in the inspector.

"
	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consumed: true.
		(e modifiers isShift) ifTrue: [ e target phlow spawnObject: self]
		ifFalse: [e target phlow spawnObject: mondrian].
	]
]

{ #category : #accessing }
CRCanvas >> paint [
"I add all Nodes and edges as children to the canvas"
	self assert: [nodes notNil] description: 'You need to set the nodeGroup first'.
	self addChildren: nodes.
	self addChildren: edges.
]

{ #category : #accessing }
CRCanvas >> removeHighlight [
"I remove the highlights of all nodes that I contain."
	super removeHighlight.
	nodes removeAllHighlights
]

{ #category : #accessing }
CRCanvas >> removeHighlightOnClick [
"I add an Eventhandler that removes hilights from the nodes when the canvas is clicked on."
	self addEventHandlerOn: BlClickEvent do: [:e |
		(e target = self) ifTrue: [nodes removeHighlights]
	]
]

{ #category : #accessing }
CRCanvas >> requestFocusOnClick: aElement [
"I add an eventhandler that requests the focus when the canvas is clicked on. This is uesd for the Shortcuts"
	aElement addEventHandlerOn: BlClickEvent do: [:e | 
		e consumed: true. 
		e currentTarget requestFocus].
]

{ #category : #accessing }
CRCanvas >> setEdgeGroup: aCRGroup [
"I am a setter method for the edges"
	edges := aCRGroup
]

{ #category : #accessing }
CRCanvas >> setNodeGroup: aCRGroup [
"I am a setter method for the nodes The nodes should be provided as CRBindingGroup"
	self assert: [aCRGroup class = CRBindingGroup] description: 'You need to provide the nodes as CRBindingGroup'.
	nodes := aCRGroup.
]

{ #category : #accessing }
CRCanvas >> toggleDebugView [
"I enable or disable the debug view for myself and all my nodes"
	super toggleDebugView.
	nodes do: [:node |
		node toggleDebugView.
	].
	
]
