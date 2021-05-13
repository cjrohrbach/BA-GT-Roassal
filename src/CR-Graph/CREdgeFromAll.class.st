Class {
	#name : #CREdgeFromAll,
	#superclass : #CREdge,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CREdgeFromAll >> connect: nodes [
	| edges |
	
	edges := CRGroup new.
	
	nodes do: [:node |
		| coll |
		coll := (self evaluate: connectionBlock on: node nodes: nodes).
		(coll notNil and: coll size > 0)
			ifTrue: [
				coll do: [: res |
					| edge |
					edge := self createEdgeFrom: res to: node.
					edge ifNotNil: [edges add: edge].
				]
			]
	].
		
	^edges
]
