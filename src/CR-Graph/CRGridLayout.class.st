Class {
	#name : #CRGridLayout,
	#superclass : #BlGridLayout,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRGridLayout >> initialize [
	super initialize .
	self cellSpacing: 10.
	^ self 
]

{ #category : #accessing }
CRGridLayout >> on: aCanvas [
	self columnCount: ((aCanvas shapeCount sqrt) floor) .
	aCanvas layout: (BlOnceLayout new layout: self).
]
