Class {
	#name : #CRAction,
	#superclass : #Object,
	#instVars : [
		'event',
		'block'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRAction >> addActionToNodes: someNodes [
	someNodes do: [:node | 
		node addEventHandler: (self getEventHandler).
	]
]

{ #category : #accessing }
CRAction >> getEventHandler [
	^ BlEventHandler on: event do: block
]

{ #category : #accessing }
CRAction >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRAction >> on: eventClass do: someBlock [
	event := eventClass.
	block := someBlock.
]
