Class {
	#name : #CRPrimeSieveAction,
	#superclass : #CRAction,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRPrimeSieveAction >> initialize [
	super initialize.
	event := BlClickEvent.
	block := [:e | e target background: Color random].
	^self
]
