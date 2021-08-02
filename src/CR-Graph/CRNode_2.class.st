Class {
	#name : #'CRNode_2',
	#superclass : #CRHighlightable,
	#traits : 'TCRNode',
	#classTraits : 'TCRNode classTrait',
	#instVars : [
		'isMarked'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRNode_2 >> addOutGoingEdge: anEdge [
	outGoingEdges add: anEdge.
]

{ #category : #createProperties }
CRNode_2 >> addToolTip [
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
		
	centerElement aptitude: (BrGlamorousWithTooltipAptitude new
		showDelay: 0;
		hideDelay: 0;
		contentStencil: label)
]

{ #category : #highlighting }
CRNode_2 >> highlight [
	self background: (Color green alpha: 0.5).
]

{ #category : #highlighting }
CRNode_2 >> highlightAsConnected [
	"I am used to mark the object as connected with an edge"
	self background: (Color blue alpha: 0.5)
]

{ #category : #highlighting }
CRNode_2 >> highlightOnClick [
	"Add eventHandler to highlight myself when clicked on. 
	This is done trough the group because other highlighted nodes first have to have their highlight removed.
	"
	self addEventFilterOn: BlClickEvent do: [group highlightElement: self].
]

{ #category : #highlighting }
CRNode_2 >> highlightOnHover [
	self addEventHandlerOn: BlMouseEnterEvent do: [
		isMarked ifFalse: [self highlight].
		self highlightOutGoingEdges.
	].
	self addEventHandlerOn: BlMouseLeaveEvent do: [
		isMarked ifFalse: [self removeHighlight].
		self removeHighlightOutGoingEdges.
	].
]

{ #category : #highlighting }
CRNode_2 >> highlightOutGoingEdges [
	outGoingEdges do: [:e | e highlight]
]

{ #category : #accessing }
CRNode_2 >> initialize [
	super initialize.
	
	self graph beNode.
	
	self makeDraggable.
	self highlightOnHover.
	self openNodeOnShiftClick.
	self markOnClick.
	
	outGoingEdges := CRGroup new. 
	isMarked := false.
	isDebugViewActive := false.
	
	^self
]

{ #category : #createProperties }
CRNode_2 >> makeDraggable [
	"Add a eventHandler that makes me draggable"
	self addEventHandler: BlPullHandler new allowOutOfBounds.
]

{ #category : #highlighting }
CRNode_2 >> markAsClicked [
	self background: (Color red alpha: 0.5).
	isMarked := true.
]

{ #category : #highlighting }
CRNode_2 >> markOnClick [
	"Add eventHandler to highlight myself when clicked on. 
	This is done trough the group because other highlighted nodes first have to have their highlight removed.
	"
	self addEventFilterOn: BlClickEvent do: [group highlightElement: self].
]

{ #category : #accessing }
CRNode_2 >> model: anObject [
"I am a setter method for the model. I add the model as toolTipContent"
	model := anObject.
	toolTipContent := model.
	
	centerElement ifNotNil: [
		(centerElement requiersModel) ifTrue: [centerElement model: model] 
	].
]

{ #category : #createProperties }
CRNode_2 >> openNodeOnShiftClick [
	"Add a EventHandler that opens my model when I am clicked on. 
	If the shift key is pressed during the click open myself in a inspector instead of the model.
	"
	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consumed: true.
		(e modifiers isShift) ifTrue: [ e target phlow spawnObject: self]
		ifFalse: [e target phlow spawnObject: model].
	]
]

{ #category : #highlighting }
CRNode_2 >> removeHighlight [
	self background: (Color transparent).
	isMarked := false.
]

{ #category : #highlighting }
CRNode_2 >> removeHighlightOutGoingEdges [
	outGoingEdges do: [:e | e removeHighlight]
]

{ #category : #accessing }
CRNode_2 >> shape: aElement [
	self centerElement: aElement.
	self addToolTip.
]

{ #category : #accessing }
CRNode_2 >> toggleDebugView [
	"I enable or disable the debug view.
	
	The debug view is just a visible red border.
	
	This method has to be overritten for nodes that contian other nodes.
	"
	isDebugViewActive
		ifTrue: [
			self border: (BlBorder empty).
			isDebugViewActive := false.
			]
		ifFalse: [
			self border: (BlBorder paint: Color red width: 2).
			isDebugViewActive := true.
		].
]
