Class {
	#name : #CRHighlightable,
	#superclass : #BlElement,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRHighlightable class >> createHighlightable: aNode [
	| halo |
	
	
	halo := CRHighlightable new.
	halo centerElement: aNode.
	
	aNode constraintsDo: [:c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter.
	].
	
	
	^halo
	
]

{ #category : #accessing }
CRHighlightable >> initialize [
	super initialize. 
	
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	self layout: BlFrameLayout new.
	
	self constraintsDo: [:c |
		c vertical fitContent.
		c horizontal fitContent.
	].
	
	self padding: (BlInsets all: 5).
	
	^self
]

{ #category : #accessing }
CRHighlightable >> removeHighlight [
	self background: (Color transparent)
]
