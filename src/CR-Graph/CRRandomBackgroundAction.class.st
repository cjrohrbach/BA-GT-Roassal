Class {
	#name : #CRRandomBackgroundAction,
	#superclass : #CRAction,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRRandomBackgroundAction >> initialize [
	super initialize.
	event := BlClickEvent.
	block := [:e | 
	
		e target background: Color random
		
	].
	^self
]
