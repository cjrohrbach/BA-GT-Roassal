Class {
	#name : #CRActionBuilder,
	#superclass : #Object,
	#instVars : [
		'mondrian'
	],
	#category : #'CR-Graph-CR-Graph'
}

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
	| action |
	action := CRPrimeSieveAction new.
	mondrian addActionBuilder: action.
	^action
	
]

{ #category : #accessing }
CRActionBuilder >> randomBackground [
	| action |
	action := CRRandomBackgroundAction new.
	mondrian addActionBuilder: action.
	^action
]
