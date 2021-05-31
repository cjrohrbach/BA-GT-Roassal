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
CRLayoutBuilder >> force [
"I return a new CRForceLayout."
	layout := CRForceLayout new.
	^layout.
]

{ #category : #accessing }
CRLayoutBuilder >> grid [
"I return a new CRGridLayout."
	layout := CRGridLayout new.
	^layout
]

{ #category : #initialization }
CRLayoutBuilder >> initialize [
	super initialize.
	layout := CRGridLayout new.
	^self
]

{ #category : #accessing }
CRLayoutBuilder >> on: aCanvas [
"I apply the stored layout to the given canvas"
	layout on: aCanvas
]

{ #category : #accessing }
CRLayoutBuilder >> tree [
"I return a new CRTreeLayout"
	layout := CRTreeLayout new.
	^layout
]
