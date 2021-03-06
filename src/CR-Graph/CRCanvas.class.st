"
I am the canvas, every {{gtClass:CRMondrian}} has one. I hold all elements (nodes and edges) and I'm the element that is displayed.
I extend {{gtClass:BlElement}}

Before I can be used you need to call {{gtMethod:CRCanvas>>#paint}} to add all elements.

If the mondrian is displayed by itself use the {{gtMethod:CRCanvas>>canvasForView}} method to get the canvas as zoomable and pannable element with scroll to zoom and all the other properties needed to work and look good.

If the mondrian should be used within another visualization then use {{gtMethod:CRCanvas>>canvasAsNode}}. This will return the canvas with a border and the ability to click on it to open the mondrian instance it belongs to in a inspector.

"
Class {
	#name : 'CRCanvas',
	#superclass : 'BlElement',
	#instVars : [
		'nodes',
		'edges',
		'mondrian',
		'isDebugViewActive'
	],
	#category : 'CR-Graph-CR-Graph'
}

{ #category : 'accessing' }
CRCanvas class >> newFrom: someNodes edges: someEdges mondrian: aMondrian [
"I create a new canvas from the given nodes, edges and the mondrian instance"
	| c |
	c := self new .
	c setNodeGroup: someNodes.
	c setEdgeGroup: someEdges.
	c mondrian: aMondrian.
	^c
]

{ #category : 'accessing' }
CRCanvas >> addAllEdges: shapeCollection [
"I add the content of the provided collection to the collection conatining the edges"
	edges addAll: shapeCollection.
]

{ #category : 'accessing' }
CRCanvas >> addEdge: aShape [
"I add the provided shape as edge"
	edges add: aShape.
]

{ #category : 'accessing' }
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

{ #category : 'accessing' }
CRCanvas >> addToolTip: content [
	"I add a tooltip to the node. 
	The tooltip label text is the content given. 
	The ToolTip gets shown when the mouse hovers over the node.
	"
	| label labelText |
	label := [BrLabel new aptitude: 
		BrGlamorousLabelAptitude new  
			glamorousRegularFontAndSize;
			alignCenter;
			text: content].
		
	self aptitude: (BrGlamorousWithTooltipAptitude new
		showDelay: 0;
		hideDelay: 0;
		contentStencil: label)
]

{ #category : 'accessing' }
CRCanvas >> canvasAsNode [
"I return the canvas with all the properties of a normal node"
	| c |
	self openMondrianOnClick.
	self border: (BlBorder paint: Color black width: 2).
	^self
]

{ #category : 'accessing' }
CRCanvas >> canvasForView [
"I return the canvas with the properties needed to display it nicely. (i.e. scroll to zoom etc)"
	| c |
	c := BlZoomableElement new contentElement: self.
	c clipChildren: false.
	c constraintsDo: [:con |
		con horizontal matchParent.
		con vertical matchParent.
	].
	self requestFocusOnClick: c.
	self addScrollToZoom: c.
	self jumpToInitialZoomOnSpace: c.
	^ c asPannableElement

]

{ #category : 'accessing' }
CRCanvas >> getNodes [
"I return all the nodes I contain and their subnodes"
	^nodes collectAll: [:n | n getNodes]
]

{ #category : 'accessing' }
CRCanvas >> holdsNodes [
	"
	I return true if I have nodes as children.
	In this case I should implement a removeHighlight method wich removes all highlights from my children nodes.
	"
	^true
]

{ #category : 'initialization' }
CRCanvas >> initialize [
	super initialize.
	"super initializeForCanvas."
	self removeHighlightOnClick.
	
	self graph beChildrenContainer.
	
	self aptitude:
			(BrGlamorousWithContextMenuAptitude
				content: [ BrGlamorousSimpleContextMenuContent new
						items: {('Toggle Debug View' -> [ self parent el_ToggleDebugView ])};
						yourself ]).
	
	
	nodes := CRGroup new.
	edges := CRGroup new.

	self constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent].
	self clipChildren: false.
	
	isDebugViewActive := false.
	
	^self
]

{ #category : 'accessing' }
CRCanvas >> jumpToInitialZoomOnSpace: aElement [
"I add an Shortcut to the element that resets the zoomlevel when the space bar is pressed"
	aElement addShortcut: ( 
	BlShortcutWithAction new
		combination: (BlSingleKeyCombination space);
		action: [ 
			aElement zoomToFit.]).
]

{ #category : 'accessing' }
CRCanvas >> mondrian: aMondrian [
"I am a setter method for the mondrian Instance this canvas belongs to"
	mondrian := aMondrian.
]

{ #category : 'accessing' }
CRCanvas >> nodeCount [
"I return the number of nodes the canvas contains"
	^nodes size
]

{ #category : 'accessing' }
CRCanvas >> nodes [
"I am a getter method for the nodes"
	^nodes
]

{ #category : 'accessing' }
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

{ #category : 'accessing' }
CRCanvas >> paint [
"I add all Nodes and edges as children to the canvas"
	self assert: [nodes notNil] description: 'You need to set the nodeGroup first'.
	self addChildren: nodes.
	self addChildren: edges.
]

{ #category : 'accessing' }
CRCanvas >> removeHighlight [
"I remove the highlights of all nodes that I contain."
	nodes removeAllHighlights
]

{ #category : 'accessing' }
CRCanvas >> removeHighlightOnClick [
"I add an Eventhandler that removes hilights from the nodes when the canvas is clicked on."
	self addEventHandlerOn: BlClickEvent do: [:e |
		(e target = self) ifTrue: [nodes removeHighlights]
	]
]

{ #category : 'accessing' }
CRCanvas >> requestFocusOnClick: aElement [
"I add an eventhandler that requests the focus when the canvas is clicked on. This is uesd for the Shortcuts"
	aElement addEventHandlerOn: BlClickEvent do: [:e | 
		e consumed: true. 
		e currentTarget requestFocus].
]

{ #category : 'accessing' }
CRCanvas >> setEdgeGroup: aCRGroup [
"I am a setter method for the edges"
	edges := aCRGroup
]

{ #category : 'accessing' }
CRCanvas >> setNodeGroup: aCRGroup [
"I am a setter method for the nodes The nodes should be provided as CRBindingGroup"
	self assert: [aCRGroup class = CRBindingGroup] description: 'You need to provide the nodes as CRBindingGroup'.
	nodes := aCRGroup.
]
