"
I represent a ShapeBuilder specific for building CRBox nodes
"
Class {
	#name : 'CRBoxBuilder',
	#superclass : 'CRShapeBuilder',
	#instVars : [
		'width',
		'height',
		'borderWidth',
		'borderColor',
		'background',
		'size'
	],
	#category : 'CR-Graph-ShapeBuilder'
}

{ #category : 'accessing' }
CRBoxBuilder >> background: aValueOrAOneArgBlock [
"
	I am a setter method for the background.
	I can receive either a symbol, a block or a color.
"
	background := aValueOrAOneArgBlock.
]

{ #category : 'accessing' }
CRBoxBuilder >> borderColor: aColorOrAOneArgBlock [
"
	I am a setter method for the borderColor.
	I can receive either a symbol, a block or a color.
"
	borderColor := aColorOrAOneArgBlock
]

{ #category : 'accessing' }
CRBoxBuilder >> borderWidth: aValueOrAOneArgBlock [
"
	I am a setter method for the borderWidth.
	I can receive either a symbol, a block or a value.
"
	borderWidth := aValueOrAOneArgBlock
]

{ #category : 'accessing' }
CRBoxBuilder >> createShapeFor: obj [
"
	I create a CRCicle with the given object as model according to the stored specification.
"
	| shape |
	shape := CRBox new.
	
	
	size ifNotNil: [shape size: ((self evaluate: size on: obj) asPoint)].	
	width ifNotNil: [shape width: (self evaluate: width on: obj)].
	height ifNotNil: [shape height: (self evaluate: height on: obj)].
	background ifNotNil: [shape background: (self evaluate: background on: obj)].
		
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

{ #category : 'accessing' }
CRBoxBuilder >> height: aValueOrAOneArgBlock [
"
	I am a setter method for the height.
	I can receive either a symbol, a block or a value.
"
	height := aValueOrAOneArgBlock.
]

{ #category : 'initialization' }
CRBoxBuilder >> initialize [
	super initialize.
	^self
]

{ #category : 'accessing' }
CRBoxBuilder >> size: aValueOrAOneArgBlock [
"
	I am a setter method for the size.
	I can receive either a symbol, a block or a value.
"
	size := aValueOrAOneArgBlock 
	
]

{ #category : 'accessing' }
CRBoxBuilder >> width: aValueOrAOneArgBlock [
"
	I am a setter method for the width.
	I can receive either a symbol, a block or a value.
"
	width := aValueOrAOneArgBlock.
]
