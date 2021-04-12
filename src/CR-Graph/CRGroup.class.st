"
I represent an OrderedCollection, with some specific methods to help build graphs.
I usually hold nodes and edges.
"
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
CRGroup >> removeHighlights [
	highlightedNode ifNotNil: [ highlightedNode removeHighlight].
	highlightedNode := nil.
]

{ #category : #accessing }
CRGroup >> shapesFromModel: aObject [
" returns all shapes matching the objects as new CRGroup "
	| group |
	group := CRGroup new.
	
	self do: [:shape | (shape model = aObject) ifTrue: [group add: shape]].
	
	^ group

	
]

{ #category : #accessing }
CRGroup >> shapesFromModelArray: aArray [
	| group |
	group := CRGroup new.
	
	aArray do: [:model | 
		group addAll: (self shapesFromModel: model).
	].
	
	^ group
]
