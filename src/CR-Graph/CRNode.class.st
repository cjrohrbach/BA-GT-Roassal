"
I represent a Node Object.

My size is changed according to the centerElement (also called shape) thats added to me.
The centerElement can be any BlElement, when its added to me it becomes a node.
It is important to change the center element if you want to change my shape or color, since I myself am actually only used to have a nice background that to use as highlight when the node is clicked on or hovered over.

{{gtExample:CRNode_2>>#example}}


"
Class {
	#name : 'CRNode',
	#superclass : 'BlElement',
	#instVars : [
		'isMarked',
		'model',
		'toolTipContent',
		'outGoingEdges',
		'group',
		'centerElement',
		'anchorPosition',
		'markColor',
		'hoverColor',
		'connectColor',
		'clickColor'
	],
	#category : 'CR-Graph-CR-Graph'
}

{ #category : 'accessing' }
CRNode >> addOutGoingEdge: anEdge [
"I add the edge to the outGoingEdges collection"
	outGoingEdges add: anEdge.
]

{ #category : 'createProperties' }
CRNode >> addToolTip [
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

{ #category : 'accessing' }
CRNode >> anchorPosition [
"Getter method for the anchorPosition"
	^anchorPosition
]

{ #category : 'accessing' }
CRNode >> anchorPosition: aBlAnchor [
"Setter method for the anchorPosition"
	anchorPosition := aBlAnchor
]

{ #category : 'accessing' }
CRNode >> centerElement [
"Getter method for the centerElement"
	^centerElement
]

{ #category : 'accessing' }
CRNode >> centerElement: aElement [
"Setter method for the centerElement"
	centerElement := aElement.
	self addChild: aElement.
]

{ #category : 'accessing' }
CRNode >> clickColor: aColor [
"I change the color the node is highlighted with when clicked"
	clickColor := aColor
]

{ #category : 'accessing' }
CRNode >> connectedColor: aColor [
"I change the color the node is highlighted with when a connecting node is hovered over"
	connectColor := aColor
]

{ #category : 'accessing' }
CRNode >> example [
"I am an example used for my class comment"
	<gtExample>
	| node shape | 
	node := CRNode new
		model: 'some Model';
		group: CRBindingGroup new.
	shape := BlElement new
		background: Color blue;
		size: 100@100.
	
	node shape: shape.
	^node
]

{ #category : 'accessing' }
CRNode >> getNodes [
	"
	I return myself in a collection.
	This method is overritten when the node contains other nodes, in this case it has to return all subnodes as a collection.
	"
	
	(centerElement holdsNodes) ifTrue: [^centerElement getNodes] ifFalse: [^{self}]

]

{ #category : 'accessing' }
CRNode >> group [
"Return the CRBindingGroup I was last added to"
	^group
]

{ #category : 'accessing' }
CRNode >> group: aCRBindingGroup [
"Setter for the group. group is used to keep track of the CRBindingGroup I belong to."
	group := aCRBindingGroup
]

{ #category : 'highlighting' }
CRNode >> highlight [
"I change my background to the color predefined for highlights "
	self background: hoverColor.
]

{ #category : 'highlighting' }
CRNode >> highlightAsConnected [
	"I am used to mark the object as connected with an edge"
	self background: connectColor
]

{ #category : 'highlighting' }
CRNode >> highlightOnClick [
	"Add eventHandler to highlight myself when clicked on. 
	This is done trough the group because other highlighted nodes first have to have their highlight removed.
	"
	self addEventFilterOn: BlClickEvent do: [group highlightElement: self].
]

{ #category : 'highlighting' }
CRNode >> highlightOnHover [
"Add a EventHandler that highlights the node and all outgoing edges when hovered over the node"
	self addEventHandlerOn: BlMouseEnterEvent do: [
		isMarked ifFalse: [self highlight].
		self highlightOutGoingEdges.
	].
	self addEventHandlerOn: BlMouseLeaveEvent do: [
		isMarked ifFalse: [self removeHighlight].
		self removeHighlightOutGoingEdges.
	].
]

{ #category : 'highlighting' }
CRNode >> highlightOutGoingEdges [
"highlight all outgoing edges"
	outGoingEdges do: [:e | e highlight]
]

{ #category : 'accessing' }
CRNode >> hoverColor: aColor [
"I change the color the node is highlighted with when hovered over"
	hoverColor := aColor
]

{ #category : 'accessing' }
CRNode >> initialize [
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
	anchorPosition := BlNearestPositionEllipseAnchor.
	
	hoverColor := Color green alpha: 0.5.
	clickColor := Color red alpha: 0.5.
	connectColor := Color blue alpha: 0.5.
	
	^self
]

{ #category : 'createProperties' }
CRNode >> makeDraggable [
	"Add a eventHandler that makes me draggable"
	self addEventHandler: BlPullHandler new allowOutOfBounds.
]

{ #category : 'highlighting' }
CRNode >> markAsClicked [
"
	I mark myself as clicked. 
	Therefore I change the color of my background to the predefined clickColor
"
	self background: clickColor.
	isMarked := true.
]

{ #category : 'highlighting' }
CRNode >> markOnClick [
	"Add eventHandler to highlight myself when clicked on. 
	This is done trough the group because other highlighted nodes first have to have their highlight removed.
	"
	self addEventFilterOn: BlClickEvent do: [group highlightElement: self].
]

{ #category : 'accessing' }
CRNode >> model [
"I am getter method for the model"
	^model
]

{ #category : 'accessing' }
CRNode >> model: anObject [
"I am a setter method for the model. I add the model as toolTipContent"
	model := anObject.
	toolTipContent := model.
	
	centerElement ifNotNil: [
		(centerElement requiersModel) ifTrue: [centerElement model: model] 
	].
]

{ #category : 'accessing' }
CRNode >> noHighlights [
"I make all highlights invisible."
	hoverColor := Color transparent.
	clickColor := Color transparent.
	connectColor := Color transparent.
]

{ #category : 'createProperties' }
CRNode >> openNodeOnShiftClick [
	"Add a EventHandler that opens my model when I am clicked on. 
	If the shift key is pressed during the click open myself in a inspector instead of the model.
	"
	self addEventHandlerOn: BlClickEvent do: [ :e |
		e consumed: true.
		(e modifiers isShift) ifTrue: [ e target phlow spawnObject: self]
		ifFalse: [e target phlow spawnObject: model].
	]
]

{ #category : 'highlighting' }
CRNode >> removeHighlight [
"Remove my highlight"
	self background: (Color transparent).
	(centerElement holdsNodes) ifTrue: [centerElement removeHighlight].
	isMarked := false.
]

{ #category : 'highlighting' }
CRNode >> removeHighlightOutGoingEdges [
"I remove all highlights from the outgoing edges"
	outGoingEdges do: [:e | e removeHighlight]
]

{ #category : 'accessing' }
CRNode >> shape: aElement [
"setter method for the centerElement"
	self centerElement: aElement.
	self addToolTip.
]

{ #category : 'accessing' }
CRNode >> toolTipContent: someText [
	"Add the content for the toolTip. This can be a attribute, or just text "
	toolTipContent := someText.
]
