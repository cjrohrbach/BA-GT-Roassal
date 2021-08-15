"
I represent a ShapeBuilder specific for building CRCircle nodes
"
Class {
	#name : 'CRCircleBuilder',
	#superclass : 'CRShapeBuilder',
	#instVars : [
		'size',
		'borderWidth',
		'borderColor',
		'background'
	],
	#category : 'CR-Graph-ShapeBuilder'
}

{ #category : 'accessing' }
CRCircleBuilder >> background: aValueOrArgBlock [
"
	I am a setter method for the background.
	I can receive either a symbol, a block or a background.
"
	background := aValueOrArgBlock
]

{ #category : 'accessing' }
CRCircleBuilder >> borderColor: aValueOrArgBlock [
"
	I am a setter method for the borderColor.
	I can receive either a symbol, a block or a color.
"
	borderColor := aValueOrArgBlock
]

{ #category : 'accessing' }
CRCircleBuilder >> borderWidth: aValueOrArgBlock [
"
	I am a setter method for the borderWidth.
	I can receive either a symbol, a block or a value.
"
	borderWidth := aValueOrArgBlock
]

{ #category : 'accessing' }
CRCircleBuilder >> createShapeFor: obj [
"
	I create a CRCicle with the given object as model according to the stored specification.
"
	| shape |
	shape := CRCircle new.
	size ifNotNil: [shape size: ((self evaluate: size on: obj) asPoint)].
	background ifNotNil: [shape background: (self evaluate: background on: obj)].
		
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

{ #category : 'initialization' }
CRCircleBuilder >> initialize [
	super initialize.
	^self
]

{ #category : 'accessing' }
CRCircleBuilder >> size: aValueOrArgBlock [
"
	I am a setter method for the size.
	I can receive either a symbol, a block or a value.
"
	size := aValueOrArgBlock
]
