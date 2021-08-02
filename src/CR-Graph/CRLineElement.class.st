"
I extend BlLineElement  and am used for edges. 
I extend BlLineElement to predefine the behaviour and look.
"
Class {
	#name : #CRLineElement,
	#superclass : #BlLineElement,
	#instVars : [
		'group',
		'originalBorder'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRLineElement >> color: aColor [
"Setter method for the color the line should have"
	self border: (BlBorder paint: (aColor) width: (self border width)).
]

{ #category : #accessing }
CRLineElement >> group [
"Return the CRBindingGroup I was last added to"
	^group
]

{ #category : #accessing }
CRLineElement >> group: aCRGroup [
"Setter for the group. group is used to keep track of the CRBindingGroup I belong to."
	group := aCRGroup
]

{ #category : #accessing }
CRLineElement >> highlight [
	originalBorder := self border.
	self border: (BlBorder paint: (Color black) width: 1).
	self toAnchor referenceElement parent highlightAsConnected
]

{ #category : #initialization }
CRLineElement >> initialize [
	super initialize.
	self border: (BlBorder paint: (Color gray alpha: 0.5) width: 0.5).
	self zIndex: -1.
	
	"Add a aptitude that makes the line blue when hovering over it
	self aptitude:
		(BrStyleCommonAptitude new
			default: [:l | l border: (BlBorder paint: (Color gray alpha: 0.5) width: 0.5)];
			hovered: [ :l | l border: (BlBorder paint: Color blue width: 2) ])."
			
	
	^self
]

{ #category : #accessing }
CRLineElement >> removeHighlight [
	self border: originalBorder.
	self toAnchor referenceElement parent removeHighlight
]

{ #category : #accessing }
CRLineElement >> width: aValue [
"Setter method for the width the line should have"
	self border: (BlBorder paint: (self border paint) width: aValue).
]
