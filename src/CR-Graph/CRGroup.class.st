"
I represent an OrderedCollection, with some specific methods to help build graphs.
I usually hold nodes and edges.
"
Class {
	#name : #CRGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'highlightedNode',
		'identifier'
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
CRGroup >> nodeFromModel: aObject [
	"returns a single node matching the ojbect. Returns nil if no matching node is found"
	self do: [:node | (node model = aObject) ifTrue: [^node]].
	^nil
]

{ #category : #accessing }
CRGroup >> nodesFromModel: aObject [
" returns all shapes matching the objects as new CRGroup "
	| group |
	group := CRGroup new.
	
	self do: [:node | (node model = aObject) ifTrue: [group add: node]].
	
	^ group

	
]

{ #category : #accessing }
CRGroup >> nodesFromModelArray: aArray [
	| group |
	group := CRGroup new.
	
	aArray do: [:model | 
		group addAll: (self nodesFromModel: model).
	].
	
	^ group
]

{ #category : #accessing }
CRGroup >> removeHighlights [
	highlightedNode ifNotNil: [ highlightedNode removeHighlight].
	highlightedNode := nil.
]
