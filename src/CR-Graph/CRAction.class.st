"
I am a action. I can be used to apply the same EventHandler to all the nodes of a CRMondrian.
"
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
"adds an Eventhandler matching the action to all supplied nodes"
	someNodes do: [:node | 
		node addEventHandler: (self getEventHandler).
	]
]

{ #category : #accessing }
CRAction >> getEventHandler [
"return a BlEventHandler that matches the action, which can be added to BlElements"
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