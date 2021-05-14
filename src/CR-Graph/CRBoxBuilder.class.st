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
	background := aValueOrAOneArgBlock.
]

{ #category : #accessing }
CRBoxBuilder >> borderColor: aColorOrAOneArgBlock [
	borderColor := aColorOrAOneArgBlock
]

{ #category : #accessing }
CRBoxBuilder >> borderWidth: aValueOrAOneArgBlock [
	borderWidth := aValueOrAOneArgBlock
]

{ #category : #accessing }
CRBoxBuilder >> createShapeFor: obj [
	| result |
	result := CRBox new 
			model: obj.
		width ifNotNil: [result width: (self evaluate: width on: obj)].
		height ifNotNil: [result height: (self evaluate: height on: obj)].
		background ifNotNil: [result color: (self evaluate: background on: obj)].
		toolTipContent ifNotNil: [result toolTipContent: (self evaluate: toolTipContent on: obj)].
		
		(borderWidth notNil and: [borderColor notNil])
			ifTrue: [result border: (BlBorder paint:(self evaluate: borderColor on: obj) width: (self evaluate: borderWidth on: obj))]
			ifFalse: [
				borderWidth ifNotNil: [result border: (BlBorder paint: Color black width: (self evaluate: borderWidth on: obj))].
				borderColor ifNotNil: [result border: (BlBorder paint: (self evaluate: borderColor on: obj) width: 4)]].
		^ result
]

{ #category : #accessing }
CRBoxBuilder >> height: aValueOrAOneArgBlock [
	height := aValueOrAOneArgBlock.
]

{ #category : #accessing }
CRBoxBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRBoxBuilder >> normalizeColor: anArgBlockOrSymbol [
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
	| norm |
	norm := self normalizeColor: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRBoxBuilder >> normalizeHeight: anArgBlockOrSymbol [
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
	| norm |
	norm := self normalizeHeight: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRBoxBuilder >> normalizeWidth: anArgBlockOrSymbol [
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
	| norm |
	norm := self normalizeWidth: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRBoxBuilder >> width: aValueOrAOneArgBlock [
	width := aValueOrAOneArgBlock.
]
