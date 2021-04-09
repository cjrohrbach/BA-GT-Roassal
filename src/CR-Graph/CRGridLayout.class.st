Class {
	#name : #CRGridLayout,
	#superclass : #BlGridLayout,
	#category : #'CR-Graph-Layout'
}

{ #category : #accessing }
CRGridLayout >> initialize [
	super initialize .
	self cellSpacing: 10.
	^ self 
]

{ #category : #accessing }
CRGridLayout >> on: aCanvas [
	self columnCount: ((aCanvas nodeCount sqrt) floor) .
	aCanvas layout: (BlOnceLayout new layout: self).
]
