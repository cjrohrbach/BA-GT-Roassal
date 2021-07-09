"
I am used to choose the layout that should be used for the canvas
"
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
CRLayoutBuilder >> circle [
"I return a new CRCircleLayout."
	layout := CRCircleLayout new.
	^layout.
]

{ #category : #accessing }
CRLayoutBuilder >> cluster [
"I return a new CRClusterLayout."
	layout := CRClusterLayout new.
	^layout.
]

{ #category : #accessing }
CRLayoutBuilder >> custom: aLayout [
"I can receive any layout. I then create a CRCustomLayout wich stores it and later on applys it to the canvas"
	layout := CRCustomLayout new.
	layout layout: aLayout.
	^layout
]

{ #category : #accessing }
CRLayoutBuilder >> flow [
"I return a new CRFlowLayout."
	layout := CRFlowLayout new.
	^layout.
]

{ #category : #accessing }
CRLayoutBuilder >> force [
"I return a new CRForceLayout."
	layout := CRForceLayout new.
	^layout.
]

{ #category : #accessing }
CRLayoutBuilder >> graphviz [
"I return a new CRGraphvizLayout."
	layout := CRGraphvizLayout new.
	
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
