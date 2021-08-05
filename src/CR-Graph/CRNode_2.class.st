"
I represent a Node Object.

My size is changed according to the centerElement (also called shape) thats added to me.
The centerElement can be any BlElement, when its added to me it becomes a node.
It is important to change the center element if you want to change my shape or color, since I myself am actually only used to have a nice background that to use as highlight when the node is clicked on or hovered over.

{{gtExample:CRNode_2>>#example}}


"
Class {
	#name : #'CRNode_2',
	#superclass : #BlElement,
	#instVars : [
		'isMarked',
		'model',
		'toolTipContent',
		'outGoingEdges',
		'group',
		'centerElement'
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

{ #category : #accessing }
CRNode_2 >> centerElement [
	^centerElement
]

{ #category : #accessing }
CRNode_2 >> centerElement: aElement [
	centerElement := aElement.
	self addChild: aElement.
]

{ #category : #accessing }
CRNode_2 >> example [
	<gtExample>
	| node shape | 
	node := CRNode_2 new
		model: 'some Model';
		group: CRBindingGroup new.
	shape := BlElement new
		background: Color blue;
		size: 100@100.
	
	node shape: shape.
	^node
]

{ #category : #accessing }
CRNode_2 >> getNodes [
	"
	I return myself in a collection.
	This method is overritten when the node contains other nodes, in this case it has to return all subnodes as a collection.
	"
	^ {self}
]

{ #category : #accessing }
CRNode_2 >> group [
"Return the CRBindingGroup I was last added to"
	^group
]

{ #category : #accessing }
CRNode_2 >> group: aCRBindingGroup [
"Setter for the group. group is used to keep track of the CRBindingGroup I belong to."
	group := aCRBindingGroup
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
	
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	self layout: BlFrameLayout new.
	
	self constraintsDo: [:c |
		c vertical fitContent.
		c horizontal fitContent.
	].
	
	self padding: (BlInsets all: 5).
	
	self graph beNode.
	
	self makeDraggable.
	self highlightOnHover.
	self openNodeOnShiftClick.
	self markOnClick.
	
	outGoingEdges := CRGroup new. 
	isMarked := false.
	
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
CRNode_2 >> model [
"I am getter method for the model"
	^model
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

{ #category : #accessing }
CRNode_2 >> noToolTip [
	
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
	(centerElement holdsNodes) ifTrue: [centerElement removeHighlight].
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
CRNode_2 >> toolTipContent: someText [
	"Add the content for the toolTip. This can be a attribute, or just text "
	toolTipContent := someText.
]
