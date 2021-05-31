Class {
	#name : #CRPointBuilder,
	#superclass : #CRShapeBuilder,
	#classVars : [
		'background',
		'borderColor',
		'borderWidth',
		'size'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRPointBuilder >> background: aValueOrArgBlock [
"I am a setter method for the background"
	background := aValueOrArgBlock
]

{ #category : #accessing }
CRPointBuilder >> borderColor: aValueOrArgBlock [
"I am a setter method for the borderColor"
	borderColor := aValueOrArgBlock
]

{ #category : #accessing }
CRPointBuilder >> borderWidth: aValueOrArgBlock [
"I am a setter method for the borderWidth"
	borderWidth := aValueOrArgBlock
]

{ #category : #accessing }
CRPointBuilder >> createShapeFor: obj [
"
	I create the node for the given object.
	Therfore I create a new CRpoint, add the object as model
	and then adapt the point to match the specifications.
"
	| result |
	result := CRPoint new 
			model: obj.
		size ifNotNil: [result size: ((self evaluate: size on: obj) asPoint)].
		background ifNotNil: [result color: (self evaluate: background on: obj)].
		toolTipContent ifNotNil: [result toolTipContent: (self evaluate: toolTipContent on: obj)].
		
		(borderWidth notNil and: [borderColor notNil])
			ifTrue: [result border: (BlBorder paint:(self evaluate: borderColor on: obj) width: (self evaluate: borderWidth on: obj))]
			ifFalse: [
				borderWidth ifNotNil: [result border: (BlBorder paint: Color black width: (self evaluate: borderWidth on: obj))].
				borderColor ifNotNil: [result border: (BlBorder paint: (self evaluate: borderColor on: obj) width: 4)]].
		^ result
]

{ #category : #initialization }
CRPointBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRPointBuilder >> normalizeColor: anArgBlockOrSymbol [
"
	I create a color normalizer using the given 
	block or symobl as key and some predefined colors
	as from and to color.
"
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
CRPointBuilder >> normalizeColor: anArgBlockOrSymbol from: fromValue to: toValue [
"
	I create a color normalizer using the given block or symbol as key
	and the fromValue and toValue as from and to color.
"
	| norm |
	norm := self normalizeColor: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRPointBuilder >> normalizeSize: anArgBlockOrSymbol [
"
	I create a size normalizer using the given 
	block or symobl as key and some predefined sizes
	as from and to size.
"
	| norm |
	
	norm := CRNormalizer new
			key: anArgBlockOrSymbol;
			attribute: [:node :value | node size: value@value];
			from: 10;
			to: 50.
	
	normalizerCollection add: norm.
	^ norm
]

{ #category : #accessing }
CRPointBuilder >> normalizeSize: anArgBlockOrSymbol from: fromValue to: toValue [
"
	I create a size normalizer using the given block or symbol as key
	and the fromValue and toValue as from and to size.
"
	| norm |
	norm := self normalizeSize: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRPointBuilder >> size: aValueOrArgBlock [
"I am a setter method for the size of the point. This can be a value, a symobl or a block"
	size := aValueOrArgBlock
]
