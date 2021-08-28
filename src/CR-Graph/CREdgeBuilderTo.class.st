"
I create an edge from the node to the block result
"
Class {
	#name : 'CREdgeBuilderTo',
	#superclass : 'CREdgeBuilder',
	#category : 'CR-Graph-CR-Graph'
}

{ #category : 'accessing' }
CREdgeBuilderTo >> connect: nodes [
"
	I create the edges according to the given block and specification.
	Therefore I'll, for each node, evaluate the connectionBlock with its
	model, fetch the node matching the result and then create the edge.
	
	All edges are collected in a CRGroup and then returned.
"
	| edges |
	
	edges := CRGroup new.
	nodes do: [:node | 
		|toNodeModel toNode |
		
		(condition cull: node model) ifTrue: [
			toNodeModel := connectionBlock cull: (node model).
			toNode := nodes nodeFromModel: toNodeModel.
		
			toNode ifNotNil: [
				| edge |
				edge := self createEdgeFrom: node to: toNode.
				edge ifNotNil: [
					edges add: edge.
				]
			]
		]	
	].
	
	^edges
]
