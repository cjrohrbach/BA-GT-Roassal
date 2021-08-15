"
I extend BlLineElement  and am used for edges. 
I extend BlLineElement to predefine the behaviour and look.
"
Class {
	#name : 'CRLineElement',
	#superclass : 'BlLineElement',
	#traits : 'TCREdge',
	#classTraits : 'TCREdge classTrait',
	#instVars : [
		'group',
		'originalBorder',
		'highlightColor',
		'highlightWidth'
	],
	#category : 'CR-Graph-EdgeShape'
}

{ #category : 'accessing' }
CRLineElement >> highlight [
"I highlight myself and the toNode. Therfore I change my border according to the highlight color and with"
	originalBorder := self border.
	self border: (BlBorder paint: (highlightColor) width: highlightWidth).
	self toAnchor referenceElement parent highlightAsConnected
]

{ #category : 'accessing' }
CRLineElement >> highlightColor: aColor [
"set the color used to highlight edges when hovered over fromNode"
	highlightColor := aColor
]

{ #category : 'accessing' }
CRLineElement >> highlightWidth: aNumber [
"set the width used to highlight edges when hovered over fromNode"
	highlightWidth := aNumber
]

{ #category : 'accessing' }
CRLineElement >> initialize [
	super initialize.
	self border: (BlBorder paint: (Color gray alpha: 0.5) width: 0.5).
	self zIndex: -1.
	
	highlightColor := Color black.
	highlightWidth := 1.

	^self
]

{ #category : 'accessing' }
CRLineElement >> noHighlights [
"
	Set the highlight color and width to the same as the standard border.
	This way I don't have an highlight.
"
	highlightColor := (self border paint).
	highlightWidth := (self border width).
]
