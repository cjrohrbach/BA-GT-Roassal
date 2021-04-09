Class {
	#name : #CRNormalizer,
	#superclass : #Object,
	#instVars : [
		'minValue',
		'maxValue',
		'key',
		'nodes',
		'to',
		'from'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRNormalizer >> from: aValue [
	from := aValue
]

{ #category : #accessing }
CRNormalizer >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRNormalizer >> key: anArgBlockOrSymbol [
	| min max |
	
	key := anArgBlockOrSymbol.
	
	min := (key cull:(nodes at: 1) model).
	max := (key cull: (nodes at: (nodes size)) model).
	nodes do: [:x | 
		| res |
		res := key cull: (x model).
	
		(res < min) ifTrue: [min := (res)].
		(res > max) ifTrue: [max := (res)].
	].
	
	minValue := min.
	maxValue := max.
	
]

{ #category : #accessing }
CRNormalizer >> maximumValue: aValue [
	maxValue := aValue
]

{ #category : #accessing }
CRNormalizer >> minimumValue: aValue [
	minValue := aValue
]

{ #category : #accessing }
CRNormalizer >> nodes: someCRNodes [
	"Set the elements that should be normalized"
	someCRNodes ifNil: [ self error: 'Should not provide nil' ].
	nodes := someCRNodes
]

{ #category : #accessing }
CRNormalizer >> normalize: anAttributeOfTheNode [
	
]

{ #category : #accessing }
CRNormalizer >> normalizeHeight [
	nodes do: [:node | node height: (self valueFor: node)].
]

{ #category : #accessing }
CRNormalizer >> to: aValue [
	to := aValue
]

{ #category : #accessing }
CRNormalizer >> valueFor: aNode [
	| nodeValue ratio |
	nodeValue := key cull: (aNode model).
	
	ratio := nodeValue / (maxValue - minValue).
	
	^ (to - from) * ratio
]
