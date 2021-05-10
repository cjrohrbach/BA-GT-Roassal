"
I build all the edges for the mondrian and then add them to the canvas.
"
Class {
	#name : #CREdgeBuilder,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'edgeShape',
		'width',
		'color',
		'fromAnchor',
		'toAnchor'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CREdgeBuilder >> arrow [
	edgeShape := CRArrowElement.
	toAnchor := BlElementTopCenterAnchor.
]

{ #category : #accessing }
CREdgeBuilder >> canvas: aCRCanvas [
	canvas := aCRCanvas
]

{ #category : #accessing }
CREdgeBuilder >> color: aColor [
	color := aColor
]

{ #category : #accessing }
CREdgeBuilder >> connectFrom: aBlockOrASymbol [
	| nodes |
	nodes := canvas nodes.
	
	nodes do: [:node |
		| fromNodeModel fromNode|
		fromNodeModel := aBlockOrASymbol cull: (node model).
		fromNode := canvas nodes nodeFromModel: fromNodeModel.
		
		fromNode ifNotNil:
			[self createEdgeFrom: fromNode to: node].
		
		
	]
]

{ #category : #accessing }
CREdgeBuilder >> connectFromAll: toBlock [
| line coll nodes|
	
	nodes := canvas nodes.
	
	nodes do: [:node | 
		coll := (self evaluate: toBlock on: node).
		(coll notNil and: coll size > 0) ifTrue: [coll do: [:res | 
			
			self createEdgeFrom: res to: node.
			
		]]].
]

{ #category : #accessing }
CREdgeBuilder >> connectTo: aBlockOrASymbol [
	| nodes |
	nodes := canvas nodes.
	
	nodes do: [:node |
		| toNodeModel toNode|
		toNodeModel := aBlockOrASymbol cull: (node model).
		toNode := canvas nodes nodeFromModel: toNodeModel.
		
		toNode ifNotNil:
			[self createEdgeFrom: node to: toNode].
		
	]
]

{ #category : #accessing }
CREdgeBuilder >> connectToAll: toBlock [
| line coll nodes|
	
	nodes := canvas nodes.
	
	nodes do: [:node | 
		coll := (self evaluate: toBlock on: node).
		(coll notNil and: coll size > 0) ifTrue: [coll do: [:res | 
			
			self createEdgeFrom: node to: res.
			
		]]].
		
]

{ #category : #accessing }
CREdgeBuilder >> createEdgeFrom: fromNode to: toNode [
	self createGraphEdgeAndAddConstraintsFrom: fromNode to: toNode.
	canvas addEdge: ((self createVisibleEdgeFrom: fromNode to: toNode))
]

{ #category : #accessing }
CREdgeBuilder >> createGraphEdgeAndAddConstraintsFrom: fromNode to: toNode [
	| edge |
	edge := GtGraphEdge new from: fromNode to: toNode.
	fromNode constraints graph addConnectedEdge: edge.
	toNode constraints graph addConnectedEdge: edge.
]

{ #category : #accessing }
CREdgeBuilder >> createVisibleEdgeFrom: fromNode to: toNode [
	| line |
	line := edgeShape new.
	
	width ifNotNil: [line width: (width)].
	color ifNotNil: [line color: (color)].
	
	line fromAnchor: (fromAnchor element: fromNode).
	line toAnchor: (toAnchor element: toNode).
	
	^ line
]

{ #category : #accessing }
CREdgeBuilder >> evaluate: aBlock on: aCRNode [
	" evaluates the given block on the object and then returns a CRGroup with all shapes that match the result "
	| result |
	result := aBlock cull: (aCRNode model).
	
	
	(result class = Array) 
		ifTrue: [^ canvas nodes nodesFromModelArray: result.]
		ifFalse: [^ canvas nodes nodesFromModel: result].
	
	
	
]

{ #category : #accessing }
CREdgeBuilder >> fromAnchor: aAnchor [
	fromAnchor := aAnchor
]

{ #category : #accessing }
CREdgeBuilder >> initialize [
	super initialize.
	self line.
	toAnchor := BlElementCenterAnchor.
	fromAnchor := BlElementCenterAnchor.
	^self
]

{ #category : #accessing }
CREdgeBuilder >> line [
	edgeShape := CRLineElement
]

{ #category : #accessing }
CREdgeBuilder >> toAnchor: aAnchor [
	toAnchor := aAnchor
]

{ #category : #accessing }
CREdgeBuilder >> width: aValue [
	width := aValue
]
