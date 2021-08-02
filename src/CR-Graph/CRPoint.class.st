"
I am a CRNode with BlCircle geometry and filled background.
"
Class {
	#name : #CRPoint,
	#superclass : #BlElement,
	#category : #'CR-Graph-NodeShape'
}

{ #category : #accessing }
CRPoint >> initialize [.
	super initialize.
	self geometry: BlCircle new.
	self size: 25 asPoint.
	self background: Color black.
	^self
]
