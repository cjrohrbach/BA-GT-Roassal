Class {
	#name : #CRLineElement,
	#superclass : #BlLineElement,
	#instVars : [
		'group'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRLineElement >> color: aColor [
	self border: (BlBorder paint: (aColor) width: (self border width)).
]

{ #category : #accessing }
CRLineElement >> group [
	^group
]

{ #category : #accessing }
CRLineElement >> group: aCRGroup [
	group := aCRGroup
]

{ #category : #accessing }
CRLineElement >> initialize [
	super initialize.
	self border: (BlBorder paint: (Color gray alpha: 0.5) width: 0.5).
	self zIndex: -1.
	^self
]

{ #category : #accessing }
CRLineElement >> width: aValue [
	self border: (BlBorder paint: (self border paint) width: aValue).
]
