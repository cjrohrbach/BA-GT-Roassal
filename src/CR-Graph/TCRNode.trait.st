"
I am a Trait used to hold all methods and class slots for CRNodes.

I'm necesary becauce CRLabel can't inherit from CRNode
"
Trait {
	#name : #TCRNode,
	#instVars : [
		'toolTipContent',
		'isDebugViewActive',
		'group',
		'originalBorder',
		'model'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
TCRNode >> addToolTip [
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
TCRNode >> color: aColor [
	self background: aColor.
]

{ #category : #accessing }
TCRNode >> group [
	^group
]

{ #category : #accessing }
TCRNode >> group: aCRGroup [
	group := aCRGroup
]

{ #category : #accessing }
TCRNode >> highlight [
	originalBorder := self border.
	self border: (BlBorder paint: (Color green alpha: 0.5) width: 5).
]

{ #category : #accessing }
TCRNode >> highlightOnClick [
	self addEventFilterOn: BlClickEvent do: [group highlightElement: self].
]

{ #category : #accessing }
TCRNode >> makeDraggable [
	self addEventHandler: BlPullHandler new allowOutOfBounds.
]

{ #category : #accessing }
TCRNode >> model [
	^model
]

{ #category : #accessing }
TCRNode >> model: anObject [
	model := anObject.
	toolTipContent := model
]

{ #category : #accessing }
TCRNode >> openNodeOnShiftClick [
	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consumed: true.
		(e modifiers isShift) ifTrue: [ e target phlow spawnObject: self]
		ifFalse: [e target phlow spawnObject: model].
	]
]

{ #category : #accessing }
TCRNode >> removeHighlight [
	self border: originalBorder
]

{ #category : #accessing }
TCRNode >> toggleDebugView [
	isDebugViewActive
		ifTrue: [
			self border: originalBorder.
			isDebugViewActive := false.
			]
		ifFalse: [
			originalBorder := self border.
			self border: (BlBorder paint: Color red width: 2).
			isDebugViewActive := true.
		].
]

{ #category : #accessing }
TCRNode >> toolTipContent: someText [
	toolTipContent := someText.
]
