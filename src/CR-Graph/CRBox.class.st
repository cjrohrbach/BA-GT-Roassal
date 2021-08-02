"
I represent a box. 
I'm just a BlElement with BlRectangleGeometry.
"
Class {
	#name : #CRBox,
	#superclass : #BlElement,
	#instVars : [
		'height',
		'width',
		'color'
	],
	#category : #'CR-Graph-NodeShape'
}

{ #category : #'as yet unclassified' }
CRBox >> addToolTip: content [
	| label labelText |
	label := [BrLabel new aptitude: 
		BrGlamorousLabelAptitude new  
			glamorousRegularFontAndSize;
			alignCenter;
			text: content].
		
	self aptitude: (BrGlamorousWithTooltipAptitude new
		showDelay: 0;
		hideDelay: 0;
		contentStencil: label)
]

{ #category : #accessing }
CRBox >> gtMondrianShape [
"I make the box look like the default element in GtMondrian. I'm mainly used for testing"
	self background: Color transparent;
		border: (BlBorder paint: Color black width: 2);
		padding: (BlInsets all: 5);
		size: 5@5;
		zIndex: 10.
]

{ #category : #accessing }
CRBox >> initialize [
	super initialize.
	self geometry: BlRectangleGeometry new.
	self width: 25.
	self height: 25.
	self background: Color black.
	^self
]
