Class {
	#name : #CRTreeLayout,
	#superclass : #GtGraphTreeLayout,
	#category : #'CR-Graph-Layout'
}

{ #category : #initialization }
CRTreeLayout >> initialize [
	super initialize.
	self verticalGap: 50.
	self horizontalGap: 50.
	^self
]

{ #category : #accessing }
CRTreeLayout >> on: aCanvas [
"I apply the layout to the given canvas. Therfore the layout is wrapped in a BlOnceLayout to maintain draggable nodes"
	aCanvas layout: (BlOnceLayout new layout: self).
]
