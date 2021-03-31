Class {
	#name : #CRGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'highlightedShape'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRGroup >> highlightElement: aShape [ 
	highlightedShape ifNotNil: [ highlightedShape removeHighlight].
	highlightedShape := aShape.
	aShape highlight.
]

{ #category : #accessing }
CRGroup >> initialize [
	super initialize.
	^ self
]
