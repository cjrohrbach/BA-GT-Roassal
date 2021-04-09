Class {
	#name : #CREdgeBuilder,
	#superclass : #Object,
	#instVars : [
		'nodes'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CREdgeBuilder >> connectTo: toBlock [
| group line coll |
	
	group := CRGroup new.
	
	nodes do: [:node | 
		coll := (self evaluate: toBlock on: node).
		(coll notNil and: coll size > 0) ifTrue: [coll do: [:res | 
			
			self createGraphEdgeAndAddConstraintsFrom: node to: res.
			group add: (self createVisibleEdgeFrom: node to: res).
			
		]]].
		
	^group
		
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
	line := CRLineElement new.
	line fromAnchor: (BlElementCenterAnchor element: fromNode).
	line toAnchor: (BlElementCenterAnchor element: toNode).
	^ line
]

{ #category : #accessing }
CREdgeBuilder >> evaluate: aBlock on: aCRNode [
	" evaluates the given block on the object and then returns a CRGroup with all shapes that match the result "
	| result |
	result := aBlock cull: (aCRNode model).
	^nodes shapesFromModel: result.
]

{ #category : #accessing }
CREdgeBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CREdgeBuilder >> nodes: aCRGroup [
	nodes := aCRGroup
]
