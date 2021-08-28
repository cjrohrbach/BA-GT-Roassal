"
I am the superclass of all edge types and I'm used to share methods between them
"
Class {
	#name : 'CREdgeBuilder',
	#superclass : 'Object',
	#instVars : [
		'toAnchorPosition',
		'fromAnchorPosition',
		'color',
		'width',
		'edgeShape',
		'connectionBlock',
		'condition',
		'noHighlights',
		'highlightColor',
		'highlightWidth'
	],
	#category : 'CR-Graph-CR-Graph'
}

{ #category : 'accessing' }
CREdgeBuilder >> color: aColor [
"Setter method for the color the edge should have"
	color := aColor
]

{ #category : 'accessing' }
CREdgeBuilder >> condition [
"I am a getter for the condition block that has to be true on all nodes that are used for the edges"
	^condition
]

{ #category : 'accessing' }
CREdgeBuilder >> condition: aTrueFalseBlock [		
"I am a setter for the condition block that has to be true on all nodes that are used for the edges"
	condition := aTrueFalseBlock
]

{ #category : 'accessing' }
CREdgeBuilder >> connect: someNodes [
	"
	I have to be implemented in the subclass according to the kind of
	connection it should be (1:n; 1:1; n:1).
	I create the edges between the nodes according to the specifications.
	"
	^self subclassResponsibility
]

{ #category : 'accessing' }
CREdgeBuilder >> connectionBlock: aBlockOrASymbol [
"Setter method for the connectionBlock"
	connectionBlock := aBlockOrASymbol
]

{ #category : 'accessing' }
CREdgeBuilder >> createAnchorFor: fromNode to: toNode [
"I create the anchor for the fromNode according to the position stored in the fromNode"
	(fromNode anchorPosition superclass = BlNearestPositionAnchor) ifTrue: [
		^fromNode anchorPosition nearestTo: toNode centerElement from: fromNode centerElement
	] ifFalse: [
		^fromNode anchorPosition element: fromNode centerElement
	]
]

{ #category : 'accessing' }
CREdgeBuilder >> createEdgeFrom: fromNode to: toNode [
"I delegate the creation of the edge. Therefore I use methods creating the graph constraints as well as the visible edge"

	"check if from and to node are the same"
	(fromNode = toNode) ifTrue: [^nil].
	
	self createGraphEdgeAndAddConstraintsFrom: fromNode to: toNode.
	^(self createVisibleEdgeFrom: fromNode to: toNode)
]

{ #category : 'accessing' }
CREdgeBuilder >> createEdges: someNodes [
"I delegate the creation of the edges between the given set of nodes."
	^self connect: someNodes.
]

{ #category : 'accessing' }
CREdgeBuilder >> createGraphEdgeAndAddConstraintsFrom: fromNode to: toNode [
"I create the graph constraints between the two nodes. This is necessary for the layouts to work."
	| edge |
	edge := GtGraphEdge new from: fromNode to: toNode.
	fromNode constraints graph addConnectedEdge: edge.
	toNode constraints graph addConnectedEdge: edge.
]

{ #category : 'accessing' }
CREdgeBuilder >> createVisibleEdgeFrom: fromNode to: toNode [
"I create the actual line between the two nodes. Therefore I use the edge shape and the provided specifications."

	| line l |
	line := edgeShape new.
	
	width ifNotNil: [line width: (width)].
	color ifNotNil: [line color: (color)].
	highlightColor ifNotNil: [line highlightColor: highlightColor].
	highlightWidth ifNotNil: [line highlightWidth: highlightWidth].
	noHighlights ifTrue: [line noHighlights].
	
	line fromAnchor: (self createAnchorFor: fromNode to: toNode).
	line toAnchor: (self createAnchorFor: toNode to: fromNode).
	
	fromNode addOutGoingEdge: line.
	
	^ line
]

{ #category : 'accessing' }
CREdgeBuilder >> edgeShape: aEdgeShape [
"Setter method for the shape of the edge."
	edgeShape := aEdgeShape
]

{ #category : 'accessing' }
CREdgeBuilder >> evaluate: aBlock on: aCRNode nodes: nodes [
	" evaluates the given block on the object and then returns a CRGroup with all shapes that match the result "
	| result |
	result := aBlock cull: (aCRNode model).
	
	
	(result isCollection) 
		ifTrue: [^ nodes nodesFromModelArray: result.]
		ifFalse: [^ nodes nodesFromModel: result].
]

{ #category : 'accessing' }
CREdgeBuilder >> fromAnchorPosition: aAnchor [
"Setter method for the fromAnchorPosition"
	fromAnchorPosition := aAnchor
]

{ #category : 'accessing' }
CREdgeBuilder >> highlightColor: aColor [
"set the color used to highlight edges when hovered over fromNode"
	highlightColor := aColor
]

{ #category : 'accessing' }
CREdgeBuilder >> highlightWidth: aNumber [
"set the color used to highlight edges when hovered over fromNode"
	highlightWidth := aNumber
]

{ #category : 'initialization' }
CREdgeBuilder >> initialize [
	super initialize.
	toAnchorPosition :=  BlNearestPositionBoundsAnchor.
	fromAnchorPosition := BlElementCenterAnchor.
	condition := [true].
	noHighlights := false.
	^self
]

{ #category : 'accessing' }
CREdgeBuilder >> noHighlights [
"remove all highlights when hovering over connected nodes"
	noHighlights := true.
]

{ #category : 'accessing' }
CREdgeBuilder >> toAnchorPosition: aAnchor [
"Setter method for the toAnchorPosition"
	toAnchorPosition := aAnchor
]

{ #category : 'accessing' }
CREdgeBuilder >> width: aValue [
"Setter method for the width of the edges"
	width := aValue.
]
