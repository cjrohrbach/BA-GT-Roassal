Class {
	#name : #CRShape,
	#superclass : #BlElement,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRShape >> color: aColor [
	self background: aColor
]

{ #category : #accessing }
CRShape >> initialize [
	super initialize.
	^self
]
