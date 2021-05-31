Class {
	#name : #CREdgeToAll,
	#superclass : #CREdge,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CREdgeToAll >> connect: nodes [
"
	I create the edges according to the given block and specification.
	Therefore I'll, for each node, evaluate the connectionBlock with its
	model, fetch all nodes matching the result and then create the edges.
	
	All edges are collected in a CRGroup and then returned.
"
	| edges |
	
	edges := CRGroup new.
	
	nodes do: [:node |
		| coll |
		coll := (self evaluate: connectionBlock on: node nodes: nodes).
		(coll notNil and: coll size > 0)
			ifTrue: [
				coll do: [: res |
					| edge |
					edge := self createEdgeFrom: node to: res.
					edge ifNotNil: [edges add: edge].
				]
			]
	].
		
	^edges
]
