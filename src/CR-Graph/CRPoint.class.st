Class {
	#name : #CRPoint,
	#superclass : #CRShape,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRPoint >> initialize [.
	super initialize.
	self geometry: BlCircle new.
	self size: 25 asPoint.
	self background: Color black.
	^self
]
