"
I am used to create Actions.

If you create any new actions predefined action classes. You should add a method like: {{gtMethod:CRActionBuilder>>primeSieve}} to make it easy to add this action to a mondrian instance
"
Class {
	#name : 'CRActionBuilder',
	#superclass : 'Object',
	#instVars : [
		'mondrian'
	],
	#category : 'CR-Graph-Action'
}

{ #category : 'accessing' }
CRActionBuilder >> custom [
"if you want to create your own custom action, call me"
	| action |
	action := CRAction new.
	mondrian addActionBuilder: action.
	^action
]

{ #category : 'initialization' }
CRActionBuilder >> initialize [
	super initialize.
	^self
]

{ #category : 'accessing' }
CRActionBuilder >> mondrian: aMondrian [
"I am a setter method for the mondrian"
	mondrian := aMondrian
]

{ #category : 'initialization' }
CRActionBuilder >> newWithMondrian: aMondrian [
" initialize myself with the provided mondrian "
	| instance | 
	instance := CRActionBuilder new .
	instance mondrian: aMondrian.
	^instance
]

{ #category : 'accessing' }
CRActionBuilder >> primeSieve [
"to create a primeSieve action call me"
	| action |
	action := CRPrimeSieveAction new.
	mondrian addActionBuilder: action.
	^action
	
]

{ #category : 'accessing' }
CRActionBuilder >> randomBackground [
"to create a randomBackground action call me"
	| action |
	action := CRRandomBackgroundAction new.
	mondrian addActionBuilder: action.
	^action
]
