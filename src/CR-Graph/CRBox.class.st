Class {
	#name : #CRBox,
	#superclass : #CRShape,
	#instVars : [
		'height',
		'width',
		'color'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRBox >> initialize [
	super initialize.
	self geometry: (BlRectangle cornerRadius: 0).
	self width: 25.
	self height: 25.
	self background: Color black.
	^self
]
