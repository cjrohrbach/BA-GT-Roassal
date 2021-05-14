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
	background := aValueOrArgBlock
]

{ #category : #accessing }
CRPointBuilder >> borderColor: aValueOrArgBlock [
	borderColor := aValueOrArgBlock
]

{ #category : #accessing }
CRPointBuilder >> borderWidth: aValueOrArgBlock [
	borderWidth := aValueOrArgBlock
]

{ #category : #accessing }
CRPointBuilder >> createShapeFor: obj [
	| result |
	result := CRPoint new 
			model: obj.
		result highlightOnClick.
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

{ #category : #accessing }
CRPointBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRPointBuilder >> normalizeColor: anArgBlockOrSymbol [
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
	| norm |
	norm := self normalizeColor: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRPointBuilder >> normalizeSize: anArgBlockOrSymbol [
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
	| norm |
	norm := self normalizeSize: anArgBlockOrSymbol.
	norm from: fromValue to: toValue.
	^norm
]

{ #category : #accessing }
CRPointBuilder >> size: aValueOrArgBlock [
	size := aValueOrArgBlock
]
