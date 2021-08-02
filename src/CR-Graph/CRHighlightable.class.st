Class {
	#name : #CRHighlightable,
	#superclass : #BlElement,
	#instVars : [
		'centerElement',
		'group'
	],
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
CRHighlightable >> centerElement [
	^centerElement
]

{ #category : #accessing }
CRHighlightable >> centerElement: aElement [
	centerElement := aElement.
	self addChild: aElement.
]

{ #category : #accessing }
CRHighlightable >> getNodes [
	^centerElement getNodes
]

{ #category : #accessing }
CRHighlightable >> group [
"Return the CRBindingGroup I was last added to"
	^group
]

{ #category : #accessing }
CRHighlightable >> group: aCRBindingGroup [
"Setter for the group. group is used to keep track of the CRBindingGroup I belong to."
	group := aCRBindingGroup
]

{ #category : #accessing }
CRHighlightable >> highlight [
	self background: (Color green alpha: 0.5).
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
CRHighlightable >> model [
	^centerElement model
]

{ #category : #accessing }
CRHighlightable >> removeHighlight [
	self background: (Color transparent)
]
