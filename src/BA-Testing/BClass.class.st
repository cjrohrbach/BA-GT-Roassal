Class {
	#name : #BClass,
	#superclass : #BlTextElement,
	#traits : 'TTraitTest',
	#classTraits : 'TTraitTest classTrait',
	#category : #'BA-Testing-TraitTesting'
}

{ #category : #accessing }
BClass >> initialize [
	super initialize.
	self background: Color blue.
	self text: ('Some text lalalala') asRopedText.
	^self
]
