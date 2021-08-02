"
I am a template to display classes with methods in categories. 
My main purpose is to be used in class blueprints.
"
Class {
	#name : #CRClassBlueprintCanvas,
	#superclass : #BlElement,
	#instVars : [
		'nodes',
		'model'
	],
	#category : #'CR-Graph-NodeShape'
}

{ #category : #accessing }
CRClassBlueprintCanvas >> addContainer: aCRCanvas [
"I add the CRCanvas (containing the methods in its category) to the canvas and its nodes to my nodes "
	aCRCanvas border: (BlBorder paint: Color black width: 0.5).
	nodes addAll: aCRCanvas getNodes.
	self addChild: aCRCanvas.
]

{ #category : #accessing }
CRClassBlueprintCanvas >> createLabel [
"I create the label on top. The label contains the class name"
	| label |
	label := BlTextElement new.
	label background: Color white.
	label margin: (BlInsets all: 20).
	label padding: (BlInsets all: 5).
	label effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 5 offset: 0@0).
	label constraintsDo: [ :con |
		con grid horizontal span: 5.
		con grid horizontal alignCenter].
	label text: model asRopedText.
	
	
	self addChild: label.
]

{ #category : #accessing }
CRClassBlueprintCanvas >> getNodes [
"I am a getter Method for the nodes"
	^nodes
]

{ #category : #initialization }
CRClassBlueprintCanvas >> initialize [
	super initialize.
	
	nodes := CRGroup new.
	
	self properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).
	self clipChildren: false.

	self border: (BlBorder paint: Color darkGray width: 1).
	self background: (Color white).
	self layout: (BlGridLayout new columnCount:5; cellSpacing: 20).
	
	^self
]

{ #category : #accessing }
CRClassBlueprintCanvas >> model: anObject [
"
	I am a setter method for the model.
	I add the model as toolTipContent.
"
	model := anObject.
	self createLabel.
]

{ #category : #accessing }
CRClassBlueprintCanvas >> removeHighlight [
"I remove all highlights from my nodes and mine"
	super removeHighlight.
	nodes removeAllHighlights
]

{ #category : #accessing }
CRClassBlueprintCanvas >> requiersModel [
	^true
]

{ #category : #accessing }
CRClassBlueprintCanvas >> toggleDebugView [
"I enable or disable the debug view for myself and all my nodes"
	super toggleDebugView.
	nodes do: [:node |
		node toggleDebugView.
	].
]
