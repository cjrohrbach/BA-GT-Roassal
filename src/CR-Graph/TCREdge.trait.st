Trait {
	#name : 'TCREdge',
	#instVars : [
		'group',
		'originalBorder'
	],
	#category : 'CR-Graph-EdgeShape'
}

{ #category : 'accessing' }
TCREdge >> color: aColor [
"Setter method for the color the line should have"
	self border: (BlBorder paint: (aColor) width: (self border width)).
]

{ #category : 'accessing' }
TCREdge >> group [
"Return the CRBindingGroup I was last added to"
	^group
]

{ #category : 'accessing' }
TCREdge >> group: aCRGroup [
"Setter for the group. group is used to keep track of the CRBindingGroup I belong to."
	group := aCRGroup
]

{ #category : 'accessing' }
TCREdge >> highlight [
"I highlight myself and the toNode"
	originalBorder := self border.
	self border: (BlBorder paint: (Color black) width: 1).
	self toAnchor referenceElement parent highlightAsConnected
]

{ #category : 'accessing' }
TCREdge >> initialize [
	super initialize.
	self border: (BlBorder paint: (Color gray alpha: 0.5) width: 0.5).
	self zIndex: -1.

	^self
]

{ #category : 'accessing' }
TCREdge >> removeHighlight [
"I remove the reset myself and the toNode to the original look"
	self border: originalBorder.
	self toAnchor referenceElement parent removeHighlight
]

{ #category : 'accessing' }
TCREdge >> width: aValue [
"Setter method for the width the line should have"
	self border: (BlBorder paint: (self border paint) width: aValue).
]
