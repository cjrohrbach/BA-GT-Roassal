"
I am a CRLineElement with an arrowhead
"
Class {
	#name : #CRArrowElement,
	#superclass : #CRLineElement,
	#instVars : [
		'originalArrow'
	],
	#category : #'CR-Graph-EdgeShape'
}

{ #category : #accessing }
CRArrowElement >> color: aColor [
"Setter method for the color the line should have"
	super color: aColor.
	self matchArrowToBorder.
]

{ #category : #accessing }
CRArrowElement >> highlight [
"I highlight myself"
	super highlight.
	originalArrow := self toHead.
	self toHead: (BlArrowheadTriangle new
		border: (BlBorder paint: (self border paint) width: (self toHead border width));
		background: (self border paint);
		scale: (self toHead scale)).
]

{ #category : #initialization }
CRArrowElement >> initialize [
	super initialize.
	self toHead: (BlArrowheadTriangle new
		border: (BlBorder paint: (self border paint) width: (self border width));
		background: (self border paint);
		scale: 4).
	^self
]

{ #category : #accessing }
CRArrowElement >> matchArrowToBorder [
"
	I match the color of the arrow to the border of the line element.
	I'm called when the color of the line element is changed
"
	self toHead 
		background: (self border paint);
		border: (BlBorder paint: (self border paint) width: (self border width)).
]

{ #category : #accessing }
CRArrowElement >> removeHighlight [
"I reset my self to the original look"
	super removeHighlight.
	
	self toHead: originalArrow.
]

{ #category : #accessing }
CRArrowElement >> width: aValue [
"Setter method for the width the line should have"
	super width: aValue.
	self toHead border: (BlBorder paint: (self border paint) width: aValue).
]
