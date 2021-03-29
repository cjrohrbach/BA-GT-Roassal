Class {
	#name : #CRCircle,
	#superclass : #CRShape,
	#category : #'CR-Graph'
}

{ #category : #accessing }
CRCircle >> initialize [
	super initialize.
	self geometry: BlCircle new.
	self size: 25 asPoint.
	self border: (BlBorder paint: Color black width: 2).
	^self
]
