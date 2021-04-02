Class {
	#name : #CRShape,
	#superclass : #BlElement,
	#instVars : [
		'model',
		'originalBorder',
		'group'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRShape >> addToolTip [
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
CRShape >> color: aColor [
	self background: aColor
]

{ #category : #accessing }
CRShape >> group [
	^group
]

{ #category : #accessing }
CRShape >> group: aCRGroup [
	group := aCRGroup
]

{ #category : #accessing }
CRShape >> highlight [
	originalBorder := self border.
	self border: (BlBorder paint: (Color green alpha: 0.5) width: 5).
]

{ #category : #accessing }
CRShape >> highlightOnClick [
	self addEventFilterOn: BlClickEvent do: [group highlightElement: self].
]

{ #category : #accessing }
CRShape >> initialize [
	super initialize.
	self addToolTip.
	self makeDraggable.
	self openModelOnClick.
	^self
]

{ #category : #accessing }
CRShape >> makeDraggable [
	self addEventHandler: BlPullHandler new allowOutOfBounds.
]

{ #category : #accessing }
CRShape >> model [
	^ model
]

{ #category : #accessing }
CRShape >> model: anObject [
	model := anObject
]

{ #category : #accessing }
CRShape >> openModelOnClick [
	self addEventHandlerOn: BlClickEvent do:[:e | e target phlow spawnObject: model].
]

{ #category : #accessing }
CRShape >> removeHighlight [
	self border: originalBorder
]
