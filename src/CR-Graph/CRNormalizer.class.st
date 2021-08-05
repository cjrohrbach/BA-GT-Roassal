"
I can be used to normalize some values over a specific scope.
"
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
		'attributeBlock',
		'condition'
	],
	#category : #'CR-Graph-Normalizer'
}

{ #category : #accessing }
CRNormalizer >> attribute: aNodeAttributeAsBlock [
	" the block must be given like this: [ :node :value | node height: value ] "
	attributeBlock := aNodeAttributeAsBlock
]

{ #category : #accessing }
CRNormalizer >> condition: aTrueFalseBlock [		
"I am a setter for the condition block that has to be true on all nodes that should be normalized"
	condition := aTrueFalseBlock
]

{ #category : #accessing }
CRNormalizer >> evaluateScope [
" I should only be called once key and nodes have been set. I evaluate the max and min value of the nodes with the given key"
	| min max |
	(nodes size = 0 ) ifTrue: [^nil].
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
"
	I am a setter method for the from value.
	The from value is the smallest value that could be assigned to a node.	
"
	from := aValue
]

{ #category : #accessing }
CRNormalizer >> from: fromValue to: toValue [
"
	I am a setter method for the from and the to value.
"
	from := fromValue.
	to := toValue.
]

{ #category : #initialization }
CRNormalizer >> initialize [
	super initialize.
	
	condition := [true].
	
	^self
]

{ #category : #accessing }
CRNormalizer >> key: anArgBlockOrSymbol [
"
	I am a setter method for the key. 
	The key is the block or the attribute that should be used to determine the value for the node.
"
	key := anArgBlockOrSymbol.
]

{ #category : #accessing }
CRNormalizer >> maximumValue: aValue [
"
	I am a setter method for the maximum value.
	The maximumValue is the biggest value of the key in the scope.
"
	maxValue := aValue
]

{ #category : #accessing }
CRNormalizer >> minimumValue: aValue [
"
	I am a setter method for the maximum value.
	The maximumValue is the smallest value of the key in the scope.
"
	minValue := aValue
]

{ #category : #accessing }
CRNormalizer >> nodes: someCRNodes [
	"Set the elements that should be normalized"
	someCRNodes ifNil: [ self error: 'Should not provide nil' ].
	nodes := someCRNodes flatCollect: [:x | (condition cull: x model) ifTrue: [{x}] ifFalse: [{}]]
]

{ #category : #accessing }
CRNormalizer >> normalize [
"Apply the normlaizer to the whole nodes provided"
	nodes do: [:node | attributeBlock cull: (node centerElement) cull: (self valueFor: node)]
	
]

{ #category : #accessing }
CRNormalizer >> normalize: aBlock [
" the block must be given like this: [ :node :value | node height: value ] "

	nodes do: [:node | aBlock cull: node cull: (self valueFor: node)]
	
]

{ #category : #accessing }
CRNormalizer >> to: aValue [
"
	I am a setter method for the to value.
	The to value is the biggest value that could be assigned to a node.	
"
	to := aValue
]

{ #category : #accessing }
CRNormalizer >> valueFor: aNode [
"
	I return the value for the given node.
	Therefore I calculate the ratio for the given
	node and then blend the from and the to value.
"
	| nodeValue ratio value |
	nodeValue := key cull: (aNode model).
	
	( (maxValue - minValue) <= 0 ) ifTrue:
		[^to].
	
	ratio := (nodeValue - minValue) / (maxValue - minValue).
	
	value := from + ((to - from) * ratio).
	
	^value
]
