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

{ #category : #accessing }
CRGroup >> shapesFromModel: aObject [
" returns all shapes matching the objects as new CRGroup "
	| group |
	group := CRGroup new.
	
	self do: [:shape | (shape model = aObject) ifTrue: [group add: shape]].
	
	^ group

	
]
