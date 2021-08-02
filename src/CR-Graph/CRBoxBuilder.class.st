"
I represent a ShapeBuilder specific for building CRBox nodes
"
Class {
	#name : #CRBoxBuilder,
	#superclass : #CRShapeBuilder,
	#instVars : [
		'width',
		'height',
		'borderWidth',
		'borderColor',
		'background'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRBoxBuilder >> background: aValueOrAOneArgBlock [
"
	I am a setter method for the background.
	I can receive either a symbol, a block or a color.
"
	background := aValueOrAOneArgBlock.
]

{ #category : #accessing }
CRBoxBuilder >> borderColor: aColorOrAOneArgBlock [
"
	I am a setter method for the borderColor.
	I can receive either a symbol, a block or a color.
"
	borderColor := aColorOrAOneArgBlock
]

{ #category : #accessing }
CRBoxBuilder >> borderWidth: aValueOrAOneArgBlock [
"
	I am a setter method for the borderWidth.
	I can receive either a symbol, a block or a value.
"
	borderWidth := aValueOrAOneArgBlock
]

{ #category : #accessing }
CRBoxBuilder >> createShapeFor: obj [
"
	I create a CRCicle with the given object as model according to the stored specification.
"
	| shape |
	shape := CRBox new.
		
	width ifNotNil: [shape width: (self evaluate: width on: obj)].
	height ifNotNil: [shape height: (self evaluate: height on: obj)].
	background ifNotNil: [shape color: (self evaluate: background on: obj)].
		
	(borderWidth notNil and: [borderColor notNil])
		ifTrue: [
			shape border: (BlBorder paint:(self evaluate: borderColor on: obj) width: (self evaluate: borderWidth on: obj))
		]
		ifFalse: [
			borderWidth ifNotNil: [shape border: (BlBorder paint: Color black width: (self evaluate: borderWidth on: obj))].
			borderColor ifNotNil: [shape border: (BlBorder paint: (self evaluate: borderColor on: obj) width: 4)]
		].
	
	
	^ shape
]

{ #category : #accessing }
CRBoxBuilder >> height: aValueOrAOneArgBlock [
"
	I am a setter method for the height.
	I can receive either a symbol, a block or a value.
"
	height := aValueOrAOneArgBlock.
]

{ #category : #initialization }
CRBoxBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRBoxBuilder >> normalizeColor: anArgBlockOrSymbol [
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
CRBoxBuilder >> normalizeColor: anArgBlockOrSymbol from: fromValue to: toValue [
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
CRBoxBuilder >> normalizeHeight: anArgBlockOrSymbol [
"
	I create a height normalizer using the given 
	block or symobl as key and some predefined heights
	as from and to value.
"
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
CRBoxBuilder >> normalizeHeight: anArgBlockOrSymbol from: fromValue to: toValue [
"
	I create a height normalizer using the given block or symbol as key
	and the fromValue and toValue as from and to value.
"
	| norm |
	norm := self normalizeHeight: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRBoxBuilder >> normalizeWidth: anArgBlockOrSymbol [
"
	I create a width normalizer using the given 
	block or symobl as key and some predefined values
	as from and to value.
"
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
CRBoxBuilder >> normalizeWidth: anArgBlockOrSymbol from: fromValue to: toValue [
"
	I create a width normalizer using the given block or symbol as key
	and the fromValue and toValue as from and to.
"
	| norm |
	norm := self normalizeWidth: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRBoxBuilder >> size: aValueOrAOneArgBlock [
"
	I am a setter method for the size.
	I can receive either a symbol, a block or a value.
"
	width := aValueOrAOneArgBlock x.
	height := aValueOrAOneArgBlock y.
]

{ #category : #accessing }
CRBoxBuilder >> width: aValueOrAOneArgBlock [
"
	I am a setter method for the width.
	I can receive either a symbol, a block or a value.
"
	width := aValueOrAOneArgBlock.
]
