"
I represent the node elements.

"
Class {
	#name : #CRNode,
	#superclass : #BlElement,
	#instVars : [
		'model',
		'originalBorder',
		'group'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRNode >> addToolTip [
	| label |
	label := [BrLabel new aptitude: 
		BrGlamorousLabelAptitude new  
			glamorousRegularFontAndSize;
			alignCenter;
			text: model].
		
	self aptitude: (BrGlamorousWithTooltipAptitude new
		showDelay: 0;
		hideDelay: 0;
		contentStencil: label)
]

{ #category : #accessing }
CRNode >> color: aColor [
	self background: aColor
]

{ #category : #accessing }
CRNode >> group [
	^group
]

{ #category : #accessing }
CRNode >> group: aCRGroup [
	group := aCRGroup
]

{ #category : #accessing }
CRNode >> highlight [
	originalBorder := self border.
	self border: (BlBorder paint: (Color green alpha: 0.5) width: 5).
]

{ #category : #accessing }
CRNode >> highlightOnClick [
	self addEventFilterOn: BlClickEvent do: [group highlightElement: self].
]

{ #category : #accessing }
CRNode >> initialize [
	super initialize.
	
	self addToolTip.
	self makeDraggable.
	self openModelOnClick.
	self graph beNode.
	
	^self
]

{ #category : #accessing }
CRNode >> initializeForCanvas [
	super initialize.
	^self
]

{ #category : #accessing }
CRNode >> makeDraggable [
	self addEventHandler: BlPullHandler new allowOutOfBounds.
]

{ #category : #accessing }
CRNode >> model [
	^ model
]

{ #category : #accessing }
CRNode >> model: anObject [
	model := anObject
]

{ #category : #accessing }
CRNode >> openModelOnClick [
	self addEventHandlerOn: BlClickEvent do:[:e | e target phlow spawnObject: model].
]

{ #category : #accessing }
CRNode >> removeHighlight [
	self border: originalBorder
]
