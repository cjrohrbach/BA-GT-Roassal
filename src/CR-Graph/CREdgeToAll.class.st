Class {
	#name : #CREdgeToAll,
	#superclass : #CREdge,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CREdgeToAll >> connect: nodes [
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
