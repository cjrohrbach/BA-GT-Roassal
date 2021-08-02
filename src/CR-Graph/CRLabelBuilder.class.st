"
I represent a ShapeBuilder specific for building CRLabel nodes
"
Class {
	#name : #CRLabelBuilder,
	#superclass : #CRShapeBuilder,
	#instVars : [
		'background'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRLabelBuilder >> background: aColorOrArgBlock [
"I am a setter method for the background."
	background := aColorOrArgBlock
]

{ #category : #accessing }
CRLabelBuilder >> createShapeFor: obj [
"I create a new label for the given object with the given color"
	| result |
	result := CRLabel new 
			model: obj.
		background ifNotNil: [result background: (self evaluate: background on: obj)].
		^ result
]

{ #category : #initialization }
CRLabelBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRLabelBuilder >> toolTip: someValue [
"A label shouldn't have a toolTip"
	^self shouldNotImplement
]
