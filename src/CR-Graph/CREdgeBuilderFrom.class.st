"
I create edges from the given block to the node
"
Class {
	#name : 'CREdgeBuilderFrom',
	#superclass : 'CREdgeBuilder',
	#category : 'CR-Graph-CR-Graph'
}

{ #category : 'accessing' }
CREdgeBuilderFrom >> connect: nodes [
"
	I create the edges according to the given block and specification.
	Therefore I'll, for each node, evaluate the connectionBlock with its
	model, fetch the node matching the result and then create the edge.
	
	All edges are collected in a CRGroup and then returned.
"
	| edges |
	
	edges := CRGroup new.
	
	nodes do: [:node | 
		|fromNodeModel fromNode |
		
		(condition cull: node model) ifTrue: [
			fromNodeModel := connectionBlock cull: (node model).
			fromNode := nodes nodeFromModel: fromNodeModel.
		
			fromNode ifNotNil: [
				| edge |
				edge := self createEdgeFrom: fromNode to: node.
				edge ifNotNil: [
					edges add: edge.
				]
			]
		]	
	].
	
	^edges
]
