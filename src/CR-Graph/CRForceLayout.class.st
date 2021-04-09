Class {
	#name : #CRForceLayout,
	#superclass : #GtGraphForceBasedLayout,
	#category : #'CR-Graph-Layout'
}

{ #category : #accessing }
CRForceLayout >> initialize [
	super initialize.
	self length: 100.
	^self
]

{ #category : #accessing }
CRForceLayout >> on: aCanvas [
	aCanvas layout: (BlOnceLayout new layout: self)
]
