Class {
	#name : #CRClassBlueprintCanvas,
	#superclass : #CRNode,
	#instVars : [
		'nodes'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRClassBlueprintCanvas >> addContainer: aCRCanvas [
	aCRCanvas border: (BlBorder paint: Color black width: 0.5).
	nodes addAll: aCRCanvas getNodes.
	self addChild: aCRCanvas.
]

{ #category : #accessing }
CRClassBlueprintCanvas >> createContainer [
	| c |
	c := BlElement new
		size: 100@200;
		border: (BlBorder paint: Color black width: 0.5).
	^c
]

{ #category : #accessing }
CRClassBlueprintCanvas >> createLabel [
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
	^nodes
]

{ #category : #accessing }
CRClassBlueprintCanvas >> initialize [
	super initialize.
	
	nodes := OrderedCollection new.
	
	self properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).
	self clipChildren: false.

	self border: (BlBorder paint: Color darkGray width: 1).
	self background: Color white.
	self layout: (BlGridLayout new columnCount:5; cellSpacing: 20).
	
	^self
]

{ #category : #accessing }
CRClassBlueprintCanvas >> model: anObject [
	model := anObject.
	toolTipContent := model.
	self createLabel.
]
