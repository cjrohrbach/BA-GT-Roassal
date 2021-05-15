"
I represent the node elements.

"
Class {
	#name : #CRNode,
	#superclass : #BlElement,
	#instVars : [
		'model',
		'originalBorder',
		'group',
		'toolTipContent'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRNode >> addToolTip [
	| label labelText |
	

	label := [BrLabel new aptitude: 
		BrGlamorousLabelAptitude new  
			glamorousRegularFontAndSize;
			alignCenter;
			text: toolTipContent].
		
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
	self openNodeOnShiftClick.
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
	model := anObject.
	toolTipContent := model
]

{ #category : #accessing }
CRNode >> openModelOnClick [
	self addEventHandlerOn: BlClickEvent do:[:e | e target phlow spawnObject: model].
]

{ #category : #accessing }
CRNode >> openNodeOnClick [
	self addEventHandlerOn: BlClickEvent do: [ :e |
		(e modifiers isShift) ifTrue: [ e target phlow spanwObject: self]
	]
]

{ #category : #accessing }
CRNode >> openNodeOnShiftClick [
	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consumed: true.
		(e modifiers isShift) ifTrue: [ e target phlow spawnObject: self]
	]
]

{ #category : #accessing }
CRNode >> removeHighlight [
	self border: originalBorder
]

{ #category : #accessing }
CRNode >> toolTipContent: someText [
	toolTipContent := someText.
]
