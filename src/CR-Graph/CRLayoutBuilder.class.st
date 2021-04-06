Class {
	#name : #CRLayoutBuilder,
	#superclass : #Object,
	#instVars : [
		'layoutClass',
		'layout'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRLayoutBuilder >> grid [
	layout := CRGridLayout new.
]

{ #category : #accessing }
CRLayoutBuilder >> initialize [
	super initialize.
	layout := CRGridLayout new.
	^self
]

{ #category : #accessing }
CRLayoutBuilder >> on: aCanvas [
	layout on: aCanvas
]

{ #category : #accessing }
CRLayoutBuilder >> tree [
	layout := CRTreeLayout new.
]
