"
I represent a Node with Label Shape used in ${class:CRMondrian}$.

I extend ${class:BlTextElement}$ and implement ${class:TCRNode}$.


"
Class {
	#name : #CRLabel,
	#superclass : #BlTextElement,
	#instVars : [
		'model'
	],
	#category : #'CR-Graph-NodeShape'
}

{ #category : #initialization }
CRLabel >> initialize [
	super initialize.
	
	self background: Color white.
	self margin: (BlInsets all: 20).
	self padding: (BlInsets all: 5).
	self effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 5 offset: 0@0).
	
	^self
]

{ #category : #accessing }
CRLabel >> model [
"I am a getter method for the model"
	^model
]

{ #category : #accessing }
CRLabel >> model: anObject [
"I am a setter method for the model. I add the model as toolTipContent and as text that I display"
	model := anObject.
	self text: model asRopedText glamorousRegularFont.
]

{ #category : #accessing }
CRLabel >> requiersModel [
"
	Since my text should correspond with the model I represent, I require the model
"

	^true
]
