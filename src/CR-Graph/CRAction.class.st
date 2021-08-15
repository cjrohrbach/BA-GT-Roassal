"
I am a action. I can be used to apply the same EventHandler to all the nodes of a CRMondrian.

{{gtExample:CRMondrianExamples>>customAction|codeExpanded=true|previewExpanded=false}}
"
Class {
	#name : 'CRAction',
	#superclass : 'Object',
	#instVars : [
		'event',
		'block'
	],
	#category : 'CR-Graph-Action'
}

{ #category : 'accessing' }
CRAction >> addActionToNodes: someNodes [
"adds an Eventhandler matching the action to all supplied nodes"
	someNodes do: [:node | 
		node addEventHandler: (self getEventHandler).
	]
]

{ #category : 'accessing' }
CRAction >> getEventHandler [
"return a BlEventHandler that matches the action, which can be added to BlElements"
	^ BlEventHandler on: event do: block
]

{ #category : 'initialization' }
CRAction >> initialize [
	super initialize.
	^self
]

{ #category : 'accessing' }
CRAction >> on: eventClass do: someBlock [
	"I add the eventClass as well as the do block for the eventHandler"
	event := eventClass.
	block := someBlock.
]
