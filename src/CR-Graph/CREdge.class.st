Class {
	#name : #CREdge,
	#superclass : #Object,
	#instVars : [
		'toAnchorPosition',
		'fromAnchorPosition',
		'color',
		'width',
		'edgeShape',
		'connectionBlock'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CREdge >> color: aColor [
	color := aColor
]

{ #category : #accessing }
CREdge >> connect: someNodes [
	^self subclassResponsibility
]

{ #category : #accessing }
CREdge >> connectionBlock: aBlockOrASymbol [
	connectionBlock := aBlockOrASymbol
]

{ #category : #accessing }
CREdge >> createEdgeFrom: fromNode to: toNode [
	self createGraphEdgeAndAddConstraintsFrom: fromNode to: toNode.
	^(self createVisibleEdgeFrom: fromNode to: toNode)
]

{ #category : #accessing }
CREdge >> createEdges: someNodes [
	^self connect: someNodes.
]

{ #category : #accessing }
CREdge >> createGraphEdgeAndAddConstraintsFrom: fromNode to: toNode [
	| edge |
	edge := GtGraphEdge new from: fromNode to: toNode.
	fromNode constraints graph addConnectedEdge: edge.
	toNode constraints graph addConnectedEdge: edge.
]

{ #category : #accessing }
CREdge >> createVisibleEdgeFrom: fromNode to: toNode [
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
	fromAnchorPosition := aAnchor
]

{ #category : #accessing }
CREdge >> initialize [
	super initialize.
	toAnchorPosition := BlElementCenterAnchor.
	fromAnchorPosition := BlElementCenterAnchor.
	^self
]

{ #category : #accessing }
CREdge >> toAnchorPosition: aAnchor [
	toAnchorPosition := aAnchor
]

{ #category : #accessing }
CREdge >> width: aValue [
	width := aValue.
]
