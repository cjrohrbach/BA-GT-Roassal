Class {
	#name : #CREdgeTo,
	#superclass : #CREdge,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CREdgeTo >> connect: nodes [
	| edges | 
	edges := CRGroup new.
	
	nodes do: [ :node |
		| toNodeModel toNode |
		toNodeModel := connectionBlock cull: (node model).
		toNode := nodes nodeFromModel: toNodeModel .
		
		toNode ifNotNil: [
			| edge |
			edge := self createEdgeFrom: node to: toNode.
			edge ifNotNil: [
				edges add: edge
			].
		]
	
	]
	
	
	
	
	edges addAll: (nodes collect: [:node |
		| toNodeModel toNode|
		toNodeModel := connectionBlock cull: (node model).
		toNode := nodes nodeFromModel: toNodeModel.
		
		toNode ifNotNil:[
			self createEdgeFrom: node to: toNode
		]
		
	]).
	
	^edges
]
