Class {
	#name : #MindMapIterator,
	#superclass : #Object,
	#instVars : [
		'mindMapStructure',
		'level',
		'orderedChildren'
	],
	#category : #'CR-Graph-MindMap'
}

{ #category : #accessing }
MindMapIterator >> createOrder [
	| order children |
	orderedChildren := OrderedCollection new.
	orderedChildren := mindMapStructure allNodesAsCollection.
	orderedChildren sort: [:a :b | a depth > b depth].
	
]

{ #category : #accessing }
MindMapIterator >> hasStepLeft [
	^(orderedChildren size > 0)
]

{ #category : #accessing }
MindMapIterator >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
MindMapIterator >> mindMapStructure: ms [
	mindMapStructure := ms.
	level := mindMapStructure deepestChild parent depth.
]

{ #category : #accessing }
MindMapIterator >> popLastChildren [
	(orderedChildren size > 0) ifTrue: [ | c step |
		"((orderedChildren size = 1) and: ((orderedChildren at: 1 ) isRoot)) ifTrue: 
		[
			c := orderedChildren at: 1.
			orderedChildren remove: c.
			step := OrderedCollection new.
			step add: c.
			^step.
		]."
		
		step := OrderedCollection new.
		c := orderedChildren at: 1. 
		step addAll: c parent getChildren.
		
		c parent getChildren do: [:cn | orderedChildren remove: cn].
		
		^step
	]
	
]

{ #category : #accessing }
MindMapIterator >> popLastWithChildren [
	(orderedChildren size > 0) ifTrue: [ | c step |
		step := OrderedCollection new.
		c := orderedChildren at: 1. 
		step add: c parent.
		step addAll: c parent getChildren.
		
		c parent getChildren do: [:cn | orderedChildren remove: cn].
		
		^step
	]
	
]

{ #category : #accessing }
MindMapIterator >> popStep [
	| step |
	(orderedChildren size > 0) ifTrue: [
		step := OrderedCollection new.
		step add: self popLastChildren.
		[(orderedChildren size > 0) and: (((orderedChildren at: 1) depth) = (((step at: 1) at: 1) depth))] whileTrue:
		[
			step add: (self popLastChildren)
		].
		^step
	] ifFalse: [^nil]
	
	
]
