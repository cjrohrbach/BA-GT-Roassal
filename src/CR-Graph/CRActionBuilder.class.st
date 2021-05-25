"
I am used to create Actions
"
Class {
	#name : #CRActionBuilder,
	#superclass : #Object,
	#instVars : [
		'mondrian'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRActionBuilder >> custom [
"if you want to create your own custom action, call me"
	| action |
	action := CRAction new.
	mondrian addActionBuilder: action.
	^action
]

{ #category : #accessing }
CRActionBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRActionBuilder >> mondrian: aMondrian [
	mondrian := aMondrian
]

{ #category : #accessing }
CRActionBuilder >> newWithMondrian: aMondrian [
	| instance | 
	instance := CRActionBuilder new .
	instance mondrian: aMondrian.
	^instance
]

{ #category : #accessing }
CRActionBuilder >> primeSieve [
"to create a primeSieve action call me"
	| action |
	action := CRPrimeSieveAction new.
	mondrian addActionBuilder: action.
	^action
	
]

{ #category : #accessing }
CRActionBuilder >> randomBackground [
"to create a randomBackground action call me"
	| action |
	action := CRRandomBackgroundAction new.
	mondrian addActionBuilder: action.
	^action
]
