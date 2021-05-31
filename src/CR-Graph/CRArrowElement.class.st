"
I am a CRLineElement with an arrowhead
"
Class {
	#name : #CRArrowElement,
	#superclass : #CRLineElement,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRArrowElement >> color: aColor [
"Setter method for the color the line should have"
	super color: aColor.
	self toHead border: (BlBorder paint: (aColor) width: (self border width)).
]

{ #category : #initialization }
CRArrowElement >> initialize [
	super initialize.
	self toHead: (BlArrowheadSimpleArrow new
		border: (BlBorder paint: (self border paint) width: (self border width))).
	^self
]

{ #category : #accessing }
CRArrowElement >> width: aValue [
"Setter method for the width the line should have"
	super width: aValue.
	self toHead border: (BlBorder paint: (self border paint) width: aValue).
]
