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
	background := aColorOrArgBlock
]

{ #category : #accessing }
CRLabelBuilder >> createShapeFor: obj [
	| result |
	result := CRBox new 
			model: obj.
		background ifNotNil: [result color: (self evaluate: background on: obj)].
		^ result
]

{ #category : #accessing }
CRLabelBuilder >> initialize [
	super initialize.
	^self
]
