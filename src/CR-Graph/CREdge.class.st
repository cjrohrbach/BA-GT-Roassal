"
I am the superclass of all edge types and I'm used to share methods between them
"
Class {
	#name : #CREdge,
	#superclass : #Object,
	#instVars : [
		'toAnchorPosition',
		'fromAnchorPosition',
		'color',
		'width',
		'edgeShape',
		'connectionBlock',
		'condition'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CREdge >> color: aColor [
"Setter method for the color the edge should have"
	color := aColor
]

{ #category : #accessing }
CREdge >> condition [
"I am a setter for the condition block that has to be true on all nodes that are used for the edges"
]

{ #category : #accessing }
CREdge >> condition: aTrueFalseBlock [		
"I am a setter for the condition block that has to be true on all nodes that are used for the edges"
	condition := aTrueFalseBlock
]

{ #category : #accessing }
CREdge >> connect: someNodes [
	"
	I have to be implemented in the subclass according to the kind of
	connection it should be (1:n; 1:1; n:1).
	I create the edges between the nodes according to the specifications.
	"
	^self subclassResponsibility
]

{ #category : #accessing }
CREdge >> connectionBlock: aBlockOrASymbol [
"Setter method for the connectionBlock"
	connectionBlock := aBlockOrASymbol
]

{ #category : #accessing }
CREdge >> createEdgeFrom: fromNode to: toNode [
"I delegate the creation of the edge. Therefore I use methods creating the graph constraints as well as the visible edge"
	self createGraphEdgeAndAddConstraintsFrom: fromNode to: toNode.
	^(self createVisibleEdgeFrom: fromNode to: toNode)
]

{ #category : #accessing }
CREdge >> createEdges: someNodes [
"I delegate the creation of the edges between the given set of nodes."
	^self connect: someNodes.
]

{ #category : #accessing }
CREdge >> createGraphEdgeAndAddConstraintsFrom: fromNode to: toNode [
"I create the graph constraints between the two nodes. This is necessary for the layouts to work."
	| edge |
	edge := GtGraphEdge new from: fromNode to: toNode.
	fromNode constraints graph addConnectedEdge: edge.
	toNode constraints graph addConnectedEdge: edge.
]

{ #category : #accessing }
CREdge >> createVisibleEdgeFrom: fromNode to: toNode [
"I create the actual line between the two nodes. Therefore I use the edge shape and the provided specifications."

	| line |
	line := edgeShape new.
	
	width ifNotNil: [line width: (width)].
	color ifNotNil: [line color: (color)].
	
	line fromAnchor: (fromAnchorPosition element: fromNode).
	line toAnchor: (toAnchorPosition element: toNode).
	
	^ line
]

{ #category : #accessing }
CREdge >> edgeShape: aEdgeShape [
"Setter method for the shape of the edge."
	edgeShape := aEdgeShape
]

{ #category : #accessing }
CREdge >> evaluate: aBlock on: aCRNode nodes: nodes [
	" evaluates the given block on the object and then returns a CRGroup with all shapes that match the result "
	| result |
	result := aBlock cull: (aCRNode model).
	
	
	(result class = Array) 
		ifTrue: [^ nodes nodesFromModelArray: result.]
		ifFalse: [^ nodes nodesFromModel: result].
]

{ #category : #accessing }
CREdge >> fromAnchorPosition: aAnchor [
"Setter method for the fromAnchorPosition"
	fromAnchorPosition := aAnchor
]

{ #category : #initialization }
CREdge >> initialize [
	super initialize.
	toAnchorPosition := BlElementCenterAnchor.
	fromAnchorPosition := BlElementCenterAnchor.
	condition := [true].
	^self
]

{ #category : #accessing }
CREdge >> toAnchorPosition: aAnchor [
"Setter method for the toAnchorPosition"
	toAnchorPosition := aAnchor
]

{ #category : #accessing }
CREdge >> width: aValue [
"Setter method for the width of the edges"
	width := aValue.
]
