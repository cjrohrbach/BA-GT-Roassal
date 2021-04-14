Class {
	#name : #CRShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'width',
		'shapeClass',
		'height',
		'color',
		'borderWidth',
		'borderColor',
		'nodes',
		'normalizerCollection',
		'mondrian'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRShapeBuilder >> applyNormalizer [
	normalizerCollection do: [:normalizer |
		normalizer nodes: nodes.
		normalizer evaluateScope.
		normalizer normalize.
	].
]

{ #category : #accessing }
CRShapeBuilder >> borderColor [
	^borderColor
]

{ #category : #accessing }
CRShapeBuilder >> borderColor: aColorOrAOneArgBlock [
	borderColor := aColorOrAOneArgBlock
]

{ #category : #accessing }
CRShapeBuilder >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
CRShapeBuilder >> borderWidth: aValueOrAOneArgBlock [
	borderWidth := aValueOrAOneArgBlock
]

{ #category : #accessing }
CRShapeBuilder >> box [
	shapeClass := CRBox.
]

{ #category : #accessing }
CRShapeBuilder >> circle [
	shapeClass := CRCircle.
]

{ #category : #accessing }
CRShapeBuilder >> color [
	^color
]

{ #category : #accessing }
CRShapeBuilder >> color: aColorOrAnArgBlock [
	color := aColorOrAnArgBlock.
]

{ #category : #accessing }
CRShapeBuilder >> evaluate: aBlockClosure on: aObject [
" checks wheter the given Block is a Block or if it's just a value "
	(aBlockClosure class = BlockClosure) 
		ifTrue: [^ (aBlockClosure cull: aObject)]
		ifFalse: [^aBlockClosure]
]

{ #category : #accessing }
CRShapeBuilder >> extent: aPoint [
	width := aPoint x.
	height := aPoint y. 
]

{ #category : #accessing }
CRShapeBuilder >> height [
	^height
]

{ #category : #accessing }
CRShapeBuilder >> height: aValueOrAOneArgBlock [
	height := aValueOrAOneArgBlock
]

{ #category : #accessing }
CRShapeBuilder >> initialize [
	super initialize.
	normalizerCollection := OrderedCollection new.
	nodes := CRGroup new.
	self box.
]

{ #category : #accessing }
CRShapeBuilder >> label [
	shapeClass := CRLabel.
]

{ #category : #accessing }
CRShapeBuilder >> mondrian [ 
	^mondrian
]

{ #category : #accessing }
CRShapeBuilder >> mondrian: aCRMondrian [
	mondrian := aCRMondrian
]

{ #category : #accessing }
CRShapeBuilder >> nodes [
	^ nodes
]

{ #category : #accessing }
CRShapeBuilder >> normalizeColor: anArgBlockOrSymbol [
	| norm |
	norm := CRColorNormalizer new
		key: anArgBlockOrSymbol;
		attribute: [:node :value | node background: value];
		from: (Color gray alpha: 0.2);
		to: Color gray.
		
	normalizerCollection add: norm.
	^norm
		
]

{ #category : #accessing }
CRShapeBuilder >> normalizeColor: anArgBlockOrSymbol from: fromValue to: toValue [
	| norm |
	norm := self normalizeColor: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRShapeBuilder >> normalizeHeight: anArgBlockOrSymbol [
	| norm |
	
	norm := CRNormalizer new
			key: anArgBlockOrSymbol;
			attribute: [:node :value | node height: value];
			from: 10;
			to: 50.
	
	normalizerCollection add: norm.
	^ norm
]

{ #category : #accessing }
CRShapeBuilder >> normalizeHeight: anArgBlockOrSymbol from: fromValue to: toValue [
	| norm |
	norm := self normalizeHeight: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRShapeBuilder >> normalizeWidth: anArgBlockOrSymbol [
	| norm |
	
	norm := CRNormalizer new
			key: anArgBlockOrSymbol;
			attribute: [:node :value | node width: value];
			from: 10;
			to: 50.

	normalizerCollection add: norm.
	
	^norm
]

{ #category : #accessing }
CRShapeBuilder >> normalizeWidth: anArgBlockOrSymbol from: fromValue to: toValue [
	| norm |
	norm := self normalizeWidth: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRShapeBuilder >> point [
	shapeClass := CRPoint.
]

{ #category : #accessing }
CRShapeBuilder >> shapesOn: someObjects [
	| result group |
	
	group := CRGroup new.
	group addAll: (someObjects collect: [ :obj | 
		result := shapeClass new 
			model: obj;
			group: group.
		result highlightOnClick.
		width ifNotNil: [result width: (self evaluate: width on: obj)].
		height ifNotNil: [result height: (self evaluate: height on: obj)].
		color ifNotNil: [result color: (self evaluate: color on: obj)].
		
		(borderWidth notNil and: [borderColor notNil])
			ifTrue: [result border: (BlBorder paint:(self evaluate: borderColor on: obj) width: (self evaluate: borderWidth on: obj))]
			ifFalse: [
				borderWidth ifNotNil: [result border: (BlBorder paint: Color black width: (self evaluate: borderWidth on: obj))].
				borderColor ifNotNil: [result border: (BlBorder paint: (self evaluate: borderColor on: obj) width: 4)]].
		result
		]).
		
	^ group
]

{ #category : #accessing }
CRShapeBuilder >> size: aValueOrAOneArgBlock [
	width := aValueOrAOneArgBlock.
	height := aValueOrAOneArgBlock.
]

{ #category : #accessing }
CRShapeBuilder >> width [
	^ width
]

{ #category : #accessing }
CRShapeBuilder >> width: aValueOrAOneArgBlock [
	width := aValueOrAOneArgBlock.
]

{ #category : #accessing }
CRShapeBuilder >> with: aCollection [
	self assert: [aCollection isCollection] description: 'You need to provide a collection'.
	nodes := self shapesOn: aCollection.
	
	self applyNormalizer.
	
	mondrian addNodesToLayout: nodes.
	^ nodes
]
