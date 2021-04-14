Class {
	#name : #CRLabel,
	#superclass : #BlTextElement,
	#instVars : [
		'originalBorder',
		'group',
		'model'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRLabel >> color: aColor [
	self background: aColor
]

{ #category : #accessing }
CRLabel >> group [
	^group
]

{ #category : #accessing }
CRLabel >> group: aCRGroup [
	group := aCRGroup
]

{ #category : #accessing }
CRLabel >> highlight [
	originalBorder := self border.
	self border: (BlBorder paint: (Color green alpha: 0.5) width: 5).
]

{ #category : #accessing }
CRLabel >> highlightOnClick [
	self addEventFilterOn: BlClickEvent do: [group highlightElement: self].
]

{ #category : #accessing }
CRLabel >> initialize [
	super initialize.
	
	self graph beNode.
	self makeDraggable.
	self openModelOnClick.
	
	self background: Color white.
	self margin: (BlInsets all: 20).
	self padding: (BlInsets all: 5).
	self effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 5 offset: 0@0).
	
	^self
]

{ #category : #accessing }
CRLabel >> makeDraggable [
	self addEventHandler: BlPullHandler new allowOutOfBounds.
]

{ #category : #accessing }
CRLabel >> model [
	^ model
]

{ #category : #accessing }
CRLabel >> model: anObject [
	model := anObject.
	self text: model asRopedText glamorousRegularFont.
]

{ #category : #accessing }
CRLabel >> openModelOnClick [
	self addEventHandlerOn: BlClickEvent do:[:e | e target phlow spawnObject: model].
]
