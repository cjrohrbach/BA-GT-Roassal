Class {
	#name : #AClass,
	#superclass : #BlElement,
	#traits : 'TTraitTest',
	#classTraits : 'TTraitTest classTrait',
	#category : #'BA-Testing-TraitTesting'
}

{ #category : #accessing }
AClass >> initialize [
	super initialize.
	self background: Color blue.
	self size: 100@100.
	^self
]

{ #category : #accessing }
AClass >> test [
	 ^Color green
]
