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
	self columnCount: (((aCanvas shapeCount)/((aCanvas shapeCount sqrt) round: 0)) ceiling).
	aCanvas layout: self.
]
