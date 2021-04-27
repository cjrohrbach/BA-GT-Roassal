Class {
	#name : #CRArrowElement,
	#superclass : #CRLineElement,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRArrowElement >> color: aColor [
	super color: aColor.
	self toHead border: (BlBorder paint: (aColor) width: (self border width)).
]

{ #category : #accessing }
CRArrowElement >> initialize [
	super initialize.
	self toHead: (BlArrowheadSimpleArrow new
		border: (BlBorder paint: (self border paint) width: (self border width))).
	^self
]

{ #category : #accessing }
CRArrowElement >> width: aValue [
	super width: aValue.
	self toHead border: (BlBorder paint: (self border paint) width: aValue).
]
