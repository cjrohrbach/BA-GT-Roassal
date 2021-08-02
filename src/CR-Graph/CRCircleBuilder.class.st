"
I represent a ShapeBuilder specific for building CRCircle nodes
"
Class {
	#name : #CRCircleBuilder,
	#superclass : #CRShapeBuilder,
	#instVars : [
		'size',
		'borderWidth',
		'borderColor',
		'background'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRCircleBuilder >> background: aValueOrArgBlock [
"
	I am a setter method for the background.
	I can receive either a symbol, a block or a background.
"
	background := aValueOrArgBlock
]

{ #category : #accessing }
CRCircleBuilder >> borderColor: aValueOrArgBlock [
"
	I am a setter method for the borderColor.
	I can receive either a symbol, a block or a color.
"
	borderColor := aValueOrArgBlock
]

{ #category : #accessing }
CRCircleBuilder >> borderWidth: aValueOrArgBlock [
"
	I am a setter method for the borderWidth.
	I can receive either a symbol, a block or a value.
"
	borderWidth := aValueOrArgBlock
]

{ #category : #accessing }
CRCircleBuilder >> createShapeFor: obj [
"
	I create a CRCicle with the given object as model according to the stored specification.
"
	| shape |
	shape := CRCircle new.
	size ifNotNil: [shape size: ((self evaluate: size on: obj) asPoint)].
	background ifNotNil: [shape color: (self evaluate: background on: obj)].
		
	(borderWidth notNil and: [borderColor notNil])
		ifTrue: [
			shape border: (BlBorder paint:(self evaluate: borderColor on: obj) width: (self evaluate: borderWidth on: obj))
		]
		ifFalse: [
			borderWidth ifNotNil: [
				shape border: (BlBorder paint: Color black width: (self evaluate: borderWidth on: obj))
			].
			borderColor ifNotNil: [
				shape border: (BlBorder paint: (self evaluate: borderColor on: obj) width: 4)
			]
		].
		^ shape
]

{ #category : #initialization }
CRCircleBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRCircleBuilder >> normalizeColor: anArgBlockOrSymbol [
"
	I create a color normalizer using the given 
	block or symobl as key and some predefined colors
	as from and to color.
	The color I normalize is the border color.
"
	| norm |
	norm := CRColorNormalizer new
		key: anArgBlockOrSymbol;
		attribute: [:node :value | node border: (BlBorder paint: value width: 2)];
		from: (Color gray alpha: 0.2);
		to: Color gray.
		
	normalizerCollection add: norm.
	^norm
]

{ #category : #accessing }
CRCircleBuilder >> normalizeColor: anArgBlockOrSymbol from: fromValue to: toValue [
"
	I create a normalizer for the border color using the given block or symbol as key
	and the fromValue and toValue as from and to color.
"
	| norm |
	norm := self normalizeColor: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRCircleBuilder >> normalizeSize: anArgBlockOrSymbol [
"
	I create a size normalizer using the given 
	block or symobl as key and some predefined values
	as from and to value.
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
CRCircleBuilder >> normalizeSize: anArgBlockOrSymbol from: fromValue to: toValue [
"
	I create a size normalizer using the given block or symbol as key
	and the fromValue and toValue as from and to color.
"
	| norm |
	norm := self normalizeSize: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRCircleBuilder >> size: aValueOrArgBlock [
"
	I am a setter method for the size.
	I can receive either a symbol, a block or a value.
"
	size := aValueOrArgBlock
]
