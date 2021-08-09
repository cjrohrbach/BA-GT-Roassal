"
I represent a ShapeBuilder, and I am used to create nodes for models.
"
Class {
	#name : #CRShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'normalizerCollection',
		'modelCollection',
		'toolTipContent',
		'anchorPosition'
	],
	#category : #'CR-Graph-ShapeBuilder'
}

{ #category : #accessing }
CRShapeBuilder >> addNormalizer: aCRNormalier [
	self assert: [aCRNormalier class = CRNormalizer or: aCRNormalier class = CRColorNormalizer] description: 'You need to provide a CRNormalizer'.
	normalizerCollection add: aCRNormalier.
]

{ #category : #accessing }
CRShapeBuilder >> anchorPosition: aBlAnchor [
	anchorPosition := aBlAnchor
]

{ #category : #'node-creation' }
CRShapeBuilder >> applyNormalizer: someNodes [
"I normalize all provided nodes with the normalizers that were added druing creation."
	normalizerCollection do: [:normalizer |
		normalizer nodes: someNodes.
		normalizer evaluateScope.
		normalizer normalize.
	].
]

{ #category : #'node-creation' }
CRShapeBuilder >> createNodes [
"
	I initiate the creation of the nodes with the provided collection and specifications.
	If there is no collection provided I'll raise an Error.
	The created nodes are then returend as a CRGroup.
"
	| nodes |	
	self assert: [modelCollection isCollection] description: 'You need to provide a collection'.
	
	nodes := self shapesOn: modelCollection.
	self applyNormalizer: nodes.
	
	^nodes
]

{ #category : #normalizer }
CRShapeBuilder >> createNormalizer: anArgBlockOrSymbol from: fromValue to: toValue forAll: aTrueFalseBlock attribute: aBlockSpecifingTheAttribute [
	"I create a normlaizer using the given specification"	
			
	| norm |
	norm := CRNormalizer new
		key: anArgBlockOrSymbol; 
		attribute: aBlockSpecifingTheAttribute;
		from: fromValue;  
		to: toValue;  
		condition: aTrueFalseBlock.

	normalizerCollection add: norm.
	^norm
]

{ #category : #'node-creation' }
CRShapeBuilder >> createShapeFor: obj [
"I take an model and create and return a node matching the provided specifications. 
Therefore I have to be implemented in the subclass that holds further information about the shape.
"
	^self subclassResponsibility
]

{ #category : #'node-creation' }
CRShapeBuilder >> evaluate: aBlockClosure on: aObject [
" checks wheter the given Block is a Block or if it's just a value "
	(aBlockClosure class = BlockClosure or: aBlockClosure class = ByteSymbol) 
		ifTrue: [^ (aBlockClosure cull: aObject)]
		ifFalse: [^aBlockClosure]
]

{ #category : #initialization }
CRShapeBuilder >> initialize [
	super initialize.
	normalizerCollection := OrderedCollection new.
	^self
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeBackground: anArgBlockOrSymbol [
"
	I create a color normalizer using the given 
	block or symobl as key and some predefined colors
	as from and to color.
"
	^self normalizeBackground: anArgBlockOrSymbol 
				from: (Color gray lighter lighter lighter lighter lighter) 
				to: (Color gray darker) 
				forAll: [ true ]
		
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeBackground: anArgBlockOrSymbol forAll: aTrueFalseBlock [
"
	I create a background normalizer using the given 
	block or symobl as key and some predefined heights
	as from and to value.
	The normalizer is only applied to the objects that return true for the trueFalseBlock
"
	
	 ^ self normalizeBackground: anArgBlockOrSymbol 
				from: (Color gray lighter lighter lighter lighter lighter) 
				to: (Color gray darker) 
				forAll: aTrueFalseBlock
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeBackground: anArgBlockOrSymbol from: fromValue to: toValue [
"
	I create a color normalizer using the given block or symbol as key
	and the fromValue and toValue as from and to color.
"
	^self normalizeBackground: anArgBlockOrSymbol 
				from: fromValue 
				to: toValue
				forAll: [ true ]
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeBackground: anArgBlockOrSymbol from: fromValue to: toValue forAll: aTrueFalseBlock [
"
	I create a normalizer for the backgroundcolor, according to the specification I'm given
"
	| norm |
	norm := CRColorNormalizer new
			key: anArgBlockOrSymbol;  
			from: fromValue;
			to: toValue;
			condition: aTrueFalseBlock;  
			attribute: [ :node : value | node background: value ].
	normalizerCollection add: norm.
	^norm
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeBorderColor: anArgBlockOrSymbol [
"
	I create a color normalizer using the given 
	block or symobl as key and some predefined colors
	as from and to color.
"
	^self normalizeBorderColor: anArgBlockOrSymbol 
				from: (Color gray lighter lighter lighter lighter lighter) 
				to: (Color gray darker) 
				forAll: [ true ]
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeBorderColor: anArgBlockOrSymbol forAll: aTrueFalseBlock [
"
	I create a borderColor normalizer using the given 
	block or symobl as key and some predefined heights
	as from and to value.
	The normalizer is only applied to the objects that return true for the trueFalseBlock
"
	
	 ^ self normalizeBorderColor: anArgBlockOrSymbol 
				from: (Color gray lighter lighter lighter lighter lighter) 
				to: (Color gray darker) 
				forAll: aTrueFalseBlock
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeBorderColor: anArgBlockOrSymbol from: fromValue to: toValue [
"
	I create a bordercolor normalizer using the given block or symbol as key
	and the fromValue and toValue as from and to color.
"
	^self normalizeBorderColor: anArgBlockOrSymbol 
				from: fromValue 
				to: toValue
				forAll: [ true ]
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeBorderColor: anArgBlockOrSymbol from: fromValue to: toValue forAll: aTrueFalseBlock [
"
	I create a normalizer for the bordercolor, according to the specification I'm given
"
	| norm |
	norm := CRColorNormalizer new
			key: anArgBlockOrSymbol;  
			from: fromValue;
			to: toValue;
			condition: aTrueFalseBlock;  
			attribute: [ :node : value | node borderColor: value ] .
			
	normalizerCollection add: norm.
	^norm
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeHeight: anArgBlockOrSymbol [
"
	I create a height normalizer using the given 
	block or symobl as key and some predefined heights
	as from and to value.
"
	
	^ self normalizeHeight: anArgBlockOrSymbol from: 10 to: 50 forAll: [ true ]
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeHeight: anArgBlockOrSymbol forAll: aTrueFalseBlock [
"
	I create a height normalizer using the given 
	block or symobl as key and some predefined heights
	as from and to value.
	The normalizer is only applied to the objects that return true for the trueFalseBlock
"
	
	 ^ self normalizeHeight: anArgBlockOrSymbol from: 10 to: 50 forAll: aTrueFalseBlock
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeHeight: anArgBlockOrSymbol from: fromValue to: toValue [
"
	I create a height normalizer using the given block or symbol as key
	and the fromValue and toValue as from and to value.
"
	^self normalizeHeight: anArgBlockOrSymbol from: fromValue to: toValue forAll: [ true ]
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeHeight: anArgBlockOrSymbol from: fromValue to: toValue forAll: aTrueFalseBlock [
"
	I create a normalizer for the height, according to the specification I'm given
"

	^self createNormalizer: anArgBlockOrSymbol  
				from: fromValue  
				to: toValue 
				forAll: aTrueFalseBlock  
				attribute: [ :node : value | node height: value ]
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeWdith: anArgBlockOrSymbol forAll: aTrueFalseBlock [
"
	I create a width normalizer using the given 
	block or symobl as key and some predefined heights
	as from and to value.
	The normalizer is onlay applied to the objects that return true for the trueFalseBlock
"
	
	 ^ self normalizeWidth: anArgBlockOrSymbol from: 10 to: 50 forAll: aTrueFalseBlock
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeWidth: anArgBlockOrSymbol [
"
	I create a width normalizer using the given 
	block or symobl as key and some predefined heights
	as from and to value.
"
	
	^ self normalizeWidth: anArgBlockOrSymbol from: 10 to: 50 forAll: [ true ]
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeWidth: anArgBlockOrSymbol from: fromValue to: toValue [
"
	I create a width normalizer using the given block or symbol as key
	and the fromValue and toValue as from and to value.
"
	^self normalizeWidth: anArgBlockOrSymbol from: fromValue to: toValue forAll: [ true ]
]

{ #category : #normalizer }
CRShapeBuilder >> normalizeWidth: anArgBlockOrSymbol from: fromValue to: toValue forAll: aTrueFalseBlock [
"
	I create a normalizer for the width, according to the specification I'm given
"

	^self createNormalizer: anArgBlockOrSymbol  
				from: fromValue  
				to: toValue 
				forAll: aTrueFalseBlock  
				attribute: [ :node : value | node width: value ]

]

{ #category : #'node-creation' }
CRShapeBuilder >> shapesOn: someObjects [
"I create the nodes for the provided collection, using the createShapeFor method, and collect them as a CRGroup."

	| group |
	
	group := CRGroup new.
	group addAll: (someObjects collect: [ :obj | | node |
		node := CRNode_2 new
			shape:(self createShapeFor: obj);
			model: obj.
			
		toolTipContent ifNotNil: [node toolTipContent: (self evaluate: toolTipContent on: obj)].
		anchorPosition ifNotNil: [node anchorPosition: (self evaluate: anchorPosition on: obj)].
		
		node
		]).
		
	^ group
]

{ #category : #accessing }
CRShapeBuilder >> toolTip: someValueOrBlock [
"I'm used to set the toolTipContent variable"
	toolTipContent := someValueOrBlock
]

{ #category : #accessing }
CRShapeBuilder >> with: aCollection [
"I am a setter method for the modelCollection variable which holds the models that later are used to create the nodes"
	self assert: [aCollection isCollection] description: 'You need to provide a collection'.
	modelCollection := aCollection
]
