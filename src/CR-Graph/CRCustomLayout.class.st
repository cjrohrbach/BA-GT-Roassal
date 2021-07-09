Class {
	#name : #CRCustomLayout,
	#superclass : #Object,
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#instVars : [
		'layout'
	],
	#category : #'CR-Graph-Layout'
}

{ #category : #accessing }
CRCustomLayout >> layout: aLayout [
"set the layout"
	layout := aLayout
]

{ #category : #accessing }
CRCustomLayout >> on: aCanvas [
"I apply the layout to the given Canvas. But first I create a BlOnceLayout from myself to allow draggable nodes"
	aCanvas layout: (BlOnceLayout new layout: layout)
]
