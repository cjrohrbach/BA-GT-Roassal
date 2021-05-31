"
I represent a box. 
I'm just a BlElement with BlRectangleGeometry.
"
Class {
	#name : #CRBox,
	#superclass : #CRNode,
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
	self geometry: BlRectangleGeometry new.
	self width: 25.
	self height: 25.
	self background: Color black.
	^self
]
