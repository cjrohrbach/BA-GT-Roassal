Class {
	#name : #CRForceLayout,
	#superclass : #GtGraphForceBasedLayout,
	#category : #'CR-Graph-Layout'
}

{ #category : #initialization }
CRForceLayout >> initialize [
	super initialize.
	self length: 100.
	^self
]

{ #category : #accessing }
CRForceLayout >> on: aCanvas [
"I apply the layout to the given Canvas. But first I create a BlOnceLayout from myself to allow draggable nodes"
	aCanvas layout: (BlOnceLayout new layout: self)
]
