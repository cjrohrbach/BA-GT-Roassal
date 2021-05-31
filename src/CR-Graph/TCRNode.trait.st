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
		'model',
		'isHighlighted',
		'borderBeforeHighlight'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
TCRNode >> addToolTip [
	"I add a tooltip to the node. 
	The tooltip label text is the toolTipContent that can be defined. 
	The ToolTip gets shown when the mouse hovers over the node.
	"
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
	"Setter method for the background of the Node"
	self background: aColor.
]

{ #category : #accessing }
TCRNode >> getNodes [
	"
	I return myself in a collection.
	This method is overritten when the node contains other nodes, in this case it has to return all subnodes as a collection.
	"
	^ {self}
]

{ #category : #accessing }
TCRNode >> group [
	"Return the CRBindingGroup I was last added to"
	^group
]

{ #category : #accessing }
TCRNode >> group: aCRGroup [
	"Setter for the group. group is used to keep track of the CRBindingGroup I belong to."
	group := aCRGroup
]

{ #category : #accessing }
TCRNode >> highlight [
	"I change my border color to highlight myself, i.e. when I'm clicked on and my model opens"
	isDebugViewActive ifTrue: [
		borderBeforeHighlight := originalBorder.
	]
	ifFalse: [
		borderBeforeHighlight := self border.
	].

	self border: (BlBorder paint: (Color green alpha: 0.5) width: 5).
	isHighlighted := true.
]

{ #category : #accessing }
TCRNode >> highlightOnClick [
	"Add eventHandler to highlight myself when clicked on. 
	This is done trough the group because other highlighted nodes first have to have their highlight removed.
	"
	self addEventFilterOn: BlClickEvent do: [group highlightElement: self].
]

{ #category : #accessing }
TCRNode >> makeDraggable [
	"Add a eventHandler that makes me draggable"
	self addEventHandler: BlPullHandler new allowOutOfBounds.
]

{ #category : #accessing }
TCRNode >> model [
"I am getter method for the model"
	^model
]

{ #category : #accessing }
TCRNode >> model: anObject [
"I am a setter method for the model. I add the model as toolTipContent"
	model := anObject.
	toolTipContent := model
]

{ #category : #accessing }
TCRNode >> openNodeOnShiftClick [
	"Add a EventHandler that opens my model when I am clicked on. 
	If the shift key is pressed during the click open myself in a inspector instead of the model.
	"
	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consumed: true.
		(e modifiers isShift) ifTrue: [ e target phlow spawnObject: self]
		ifFalse: [e target phlow spawnObject: model].
	]
]

{ #category : #accessing }
TCRNode >> removeHighlight [
	"Reset my border to the original one to remove my highlight"
	self border: borderBeforeHighlight.
	isHighlighted := false.
]

{ #category : #accessing }
TCRNode >> toggleDebugView [
	"I enable or disable the debug view.
	
	The debug view is just a visible red border.
	
	This method has to be overritten for nodes that contian other nodes.
	"
	isDebugViewActive
		ifTrue: [
			self border: originalBorder.
			isDebugViewActive := false.
			]
		ifFalse: [
		
			isHighlighted ifTrue: [
				originalBorder := borderBeforeHighlight.
			]
			ifFalse: [ originalBorder := self border ].
			self border: (BlBorder paint: Color red width: 2).
			isDebugViewActive := true.
		].
]

{ #category : #accessing }
TCRNode >> toolTipContent: someText [
	"Add the content for the toolTip. This can be a attribute, or just text "
	toolTipContent := someText.
]
