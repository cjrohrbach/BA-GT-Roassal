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
			
			"add child and parent to the nodes"
			res addChildNode: node.
			node addParentNode: res.
			
			line := CRLineElement new.
			line fromAnchor: (BlElementCenterAnchor referenceElement: node relatedTo: res).
			line toAnchor: (BlElementCenterAnchor referenceElement: res relatedTo: node).
			line constraints ignoreByLayout.
			group add: line.
		]]].
		
	^group
		
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
