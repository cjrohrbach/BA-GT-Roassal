"
I am a CRNode with BlCircle geometry
"
Class {
	#name : #CRCircle,
	#superclass : #BlElement,
	#category : #'CR-Graph-NodeShape'
}

{ #category : #accessing }
CRCircle >> initialize [
	super initialize.
	self geometry: BlCircle new.
	self size: 25 asPoint.
	self border: (BlBorder paint: Color black width: 2).
	^self
]
