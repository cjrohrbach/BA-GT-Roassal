Class {
	#name : #CRShape,
	#superclass : #BlElement,
	#instVars : [
		'model'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRShape >> color: aColor [
	self background: aColor
]

{ #category : #accessing }
CRShape >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRShape >> model [
	^ model
]

{ #category : #accessing }
CRShape >> model: anObject [
	model := anObject
]
