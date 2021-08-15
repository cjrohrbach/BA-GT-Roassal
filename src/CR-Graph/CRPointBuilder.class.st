"
I represent a ShapeBuilder specific for building CRPoint nodes
"
Class {
	#name : 'CRPointBuilder',
	#superclass : 'CRShapeBuilder',
	#instVars : [
		'background',
		'borderColor',
		'borderWidth',
		'size'
	],
	#category : 'CR-Graph-ShapeBuilder'
}

{ #category : 'accessing' }
CRPointBuilder >> background: aValueOrArgBlock [
"I am a setter method for the background"
	background := aValueOrArgBlock
]

{ #category : 'accessing' }
CRPointBuilder >> borderColor: aValueOrArgBlock [
"I am a setter method for the borderColor"
	borderColor := aValueOrArgBlock
]

{ #category : 'accessing' }
CRPointBuilder >> borderWidth: aValueOrArgBlock [
"I am a setter method for the borderWidth"
	borderWidth := aValueOrArgBlock
]

{ #category : 'accessing' }
CRPointBuilder >> createShapeFor: obj [
"
	I create the node for the given object.
	Therfore I create a new CRpoint, add the object as model
	and then adapt the point to match the specifications.
"
	| shape |
	shape := CRPoint new.
		size ifNotNil: [shape size: ((self evaluate: size on: obj) asPoint)].
		background ifNotNil: [shape background: (self evaluate: background on: obj)].
		toolTipContent ifNotNil: [shape toolTipContent: (self evaluate: toolTipContent on: obj)].
		
		(borderWidth notNil and: [borderColor notNil])
			ifTrue: [shape border: (BlBorder paint:(self evaluate: borderColor on: obj) width: (self evaluate: borderWidth on: obj))]
			ifFalse: [
				borderWidth ifNotNil: [shape border: (BlBorder paint: Color black width: (self evaluate: borderWidth on: obj))].
				borderColor ifNotNil: [shape border: (BlBorder paint: (self evaluate: borderColor on: obj) width: 4)]].
		^ shape
]

{ #category : 'initialization' }
CRPointBuilder >> initialize [
	super initialize.
	^self
]

{ #category : 'accessing' }
CRPointBuilder >> size: aValueOrArgBlock [
"I am a setter method for the size of the point. This can be a value, a symobl or a block"
	size := aValueOrArgBlock
]
