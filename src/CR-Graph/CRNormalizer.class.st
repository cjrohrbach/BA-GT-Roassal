Class {
	#name : #CRNormalizer,
	#superclass : #Object,
	#instVars : [
		'minValue',
		'maxValue',
		'key',
		'nodes',
		'to',
		'from',
		'attributeBlock'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRNormalizer >> attribute: aNodeAttributeAsBlock [
	" the block must be given like this: [ :node :value | node height: value ] "
	attributeBlock := aNodeAttributeAsBlock
]

{ #category : #accessing }
CRNormalizer >> attribute: aNodeAttributeAsBlock
	" the block must be given like this: [ :node :value | node height: value ] "
	attribute: aAttribute [
]

{ #category : #accessing }
CRNormalizer >> evaluateScope [
" I should only be called once key and nodes have been set. I evaluate the max and min value of the nodes with the given key"
	| min max |
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
CRNormalizer >> from: aValue [
	from := aValue
]

{ #category : #accessing }
CRNormalizer >> from: fromValue to: toValue [
	from := fromValue.
	to := toValue.
]

{ #category : #accessing }
CRNormalizer >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRNormalizer >> key: anArgBlockOrSymbol [
	key := anArgBlockOrSymbol.
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
CRNormalizer >> normalize [

	nodes do: [:node | attributeBlock cull: node cull: (self valueFor: node)]
	
]

{ #category : #accessing }
CRNormalizer >> normalize: aBlock [
" the block must be given like this: [ :node :value | node height: value ] "

	nodes do: [:node | aBlock cull: node cull: (self valueFor: node)]
	
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
