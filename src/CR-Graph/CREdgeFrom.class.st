Class {
	#name : #CREdgeFrom,
	#superclass : #CREdge,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CREdgeFrom >> connect: nodes [
	| edges |
	
	edges := CRGroup new.
	
	nodes do: [:node | 
		|fromNodeModel fromNode |
		fromNodeModel := connectionBlock cull: (node model).
		fromNode := nodes nodeFromModel: fromNodeModel.
		
		fromNode ifNotNil: [
			| edge |
			edge := self createEdgeFrom: fromNode to: node.
			edge ifNotNil: [
				edges add: edge.
			]
		]
	].
	
	^edges
]
