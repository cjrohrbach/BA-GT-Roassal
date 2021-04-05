Class {
	#name : #CREdgeBuilder,
	#superclass : #Object,
	#instVars : [
		'shapes'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CREdgeBuilder >> connectTo: toBlock [
| group line coll |
	
	group := CRGroup new.
	
	shapes do: [:shape | 
		coll := (self evaluate: toBlock on: shape).
		(coll notNil and: coll size > 0) ifTrue: [coll do: [:res | 
			line := CRLineElement new.
			line fromAnchor: (BlElementCenterAnchor referenceElement: shape relatedTo: res).
			line toAnchor: (BlElementCenterAnchor referenceElement: res relatedTo: shape).
			line constraints ignoreByLayout.
			group add: line.
		]]].
		
	^group
		
]

{ #category : #accessing }
CREdgeBuilder >> evaluate: aBlock on: aShape [
	" evaluates the given block on the object and then returns a CRGroup with all shapes that match the result "
	| result |
	result := aBlock cull: (aShape model).
	^shapes shapesFromModel: result.
]

{ #category : #accessing }
CREdgeBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CREdgeBuilder >> shapes: aCRGroup [
	shapes := aCRGroup
]
