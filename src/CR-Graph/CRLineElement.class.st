Class {
	#name : #CRLineElement,
	#superclass : #BlLineElement,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRLineElement >> initialize [
	super initialize.
	self border: (BlBorder paint: (Color black alpha: 1) width: 2).
	self zIndex: -1.
	^self
]
