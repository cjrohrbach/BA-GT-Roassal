Class {
	#name : #CRGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'highlightedNode'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRGroup >> highlightElement: aNode [ 
	highlightedNode ifNotNil: [ highlightedNode removeHighlight].
	highlightedNode := aNode.
	aNode highlight.
]

{ #category : #accessing }
CRGroup >> initialize [
	super initialize.
	^ self
]

{ #category : #accessing }
CRGroup >> nodesFromModel: aObject [
" returns all shapes matching the objects as new CRGroup "
	| group |
	group := CRGroup new.
	
	self do: [:shape | (shape model = aObject) ifTrue: [group add: shape]].
	
	^ group

	
]

{ #category : #accessing }
CRGroup >> shapesFromModel: aObject [
" returns all shapes matching the objects as new CRGroup "
	| group |
	group := CRGroup new.
	
	self do: [:shape | (shape model = aObject) ifTrue: [group add: shape]].
	
	^ group

	
]
