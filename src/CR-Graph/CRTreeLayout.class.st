Class {
	#name : #CRTreeLayout,
	#superclass : #GtGraphTreeLayout,
	#category : #'CR-Graph-Layout'
}

{ #category : #accessing }
CRTreeLayout >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRTreeLayout >> on: aCanvas [
	| nodes |
	nodes := aCanvas nodes.
	
]
