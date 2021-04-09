Class {
	#name : #CRTreeLayout,
	#superclass : #GtGraphTreeLayout,
	#category : #'CR-Graph-Layout'
}

{ #category : #accessing }
CRTreeLayout >> initialize [
	super initialize.
	self verticalGap: 50.
	self horizontalGap: 50.
	^self
]

{ #category : #accessing }
CRTreeLayout >> on: aCanvas [
	aCanvas layout: (BlOnceLayout new layout: self).
]
