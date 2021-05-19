Class {
	#name : #CRLabel,
	#superclass : #BlTextElement,
	#traits : 'TCRNode',
	#classTraits : 'TCRNode classTrait',
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #initialization }
CRLabel >> initialize [
	super initialize.
	
	self graph beNode.
	self makeDraggable.
	self openNodeOnShiftClick.
	
	self background: Color white.
	self margin: (BlInsets all: 20).
	self padding: (BlInsets all: 5).
	self effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 5 offset: 0@0).
	
	^self
]

{ #category : #accessing }
CRLabel >> model: anObject [
	model := anObject.
	toolTipContent := model.
	self text: model asRopedText glamorousRegularFont.
]
