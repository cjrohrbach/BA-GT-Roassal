Class {
	#name : 'AClass',
	#superclass : 'BlElement',
	#traits : 'TTraitTest',
	#classTraits : 'TTraitTest classTrait',
	#instVars : [
		'b',
		'a'
	],
	#category : 'BA-Testing-TraitTesting'
}

{ #category : 'accessing' }
AClass >> abc [
	self abc: 'ab'
]

{ #category : 'accessing' }
AClass >> initialize [
	super initialize.
	self background: Color blue.
	self size: 100@100.
	a := 'abc'.
	^self
]

{ #category : 'accessing' }
AClass >> test [
	 ^Color green
]

{ #category : 'accessing' }
AClass >> test2 [ 
	^CRNormalizer new from: a; to: b .
]

{ #category : 'accessing' }
AClass >> test3 [ 
	a asComment
]
