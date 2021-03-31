Class {
	#name : #CRShape,
	#superclass : #BlElement,
	#instVars : [
		'model'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRShape >> addToolTip [
	| label |
	label := [BrLabel new look: 
		BrGlamorousLabelLook new  
			glamorousRegularFontAndSize;
			alignCenter;
			text: model].
		
	self look: (BrGlamorousWithTooltipLook new
		showDelay: 0;
		hideDelay: 0;
		contentStencil: label)
]

{ #category : #accessing }
CRShape >> color: aColor [
	self background: aColor
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
