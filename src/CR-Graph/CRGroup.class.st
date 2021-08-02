"
I represent an OrderedCollection, with some specific methods to help build graphs.
I usually hold nodes and edges.
"
Class {
	#name : #CRGroup,
	#superclass : #OrderedCollection,
	#instVars : [
		'highlightedNode',
		'identifier',
		'name'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRGroup >> gtTreeWithModelFor: aView [
"I create a view that adds a model column"
	<gtView>
	^ aView columnedTree
		title: 'Tree-Model';
		priority: 51;
		items: [ 
			self isDictionary
				ifTrue: [ self associations ]
				ifFalse: [ self asOrderedCollection ] ];
		children: [ :eachItem | 
			eachItem isDictionary
				ifTrue: [ eachItem associations ]
				ifFalse: [ 
					(eachItem isKindOf: Association)
						ifTrue: [ (eachItem value isCollection and: [
								eachItem value isString not ])
							ifTrue: [ eachItem value asOrderedCollection ]
							ifFalse: [ #() ] ]
						ifFalse: [ #() ] ] ];
		actionUpdateButtonTooltip: 'Update tree';
		column: 'Index' 
			item: [ :eachItem :eachIndex | 
				| aKey |
				aKey := (eachItem isKindOf: Association)
					ifTrue: [ eachItem key ]
					ifFalse: [ eachIndex ].
				aKey asRopedText foreground: Color gray ];
		column: 'Item' 
			text: [ :eachItem | 
				| aKey |
				aKey := (eachItem isKindOf: Association)
					ifTrue: [ eachItem value gtDisplayText ]
					ifFalse: [ eachItem gtDisplayText ] ];
		column: 'Model' 
			text: [ :eachItem | 
				| aKey |
				aKey := eachItem model]
			weight: 3.
]

{ #category : #accessing }
CRGroup >> highlightElement: aNode [ 
"
	Highlight a specific element of mine. 
	But first the current highlights get removed.

"
	highlightedNode ifNotNil: [ highlightedNode removeHighlight].
	highlightedNode := aNode.
	aNode markAsClicked.
]

{ #category : #initialization }
CRGroup >> initialize [
	super initialize.
	^ self
]

{ #category : #accessing }
CRGroup >> name [
"returns my name"
	^name
]

{ #category : #accessing }
CRGroup >> name: aName [
"Give me a name"
	name := aName.
]

{ #category : #accessing }
CRGroup >> nodeFromModel: aObject [
	"returns a single node matching the ojbect. Returns nil if no matching node is found"
	self do: [:node | (node model = aObject) ifTrue: [^node]].
	^nil
]

{ #category : #accessing }
CRGroup >> nodesFromModel: aObject [
" returns all nodes matching the objects as new CRGroup "
	| group |
	group := CRGroup new.
	
	self do: [:node | (node model = aObject) ifTrue: [group add: node]].
	
	^ group

	
]

{ #category : #accessing }
CRGroup >> nodesFromModelArray: aArray [
"I return all nodes with a model that matches the a model in the given array"
	| group |
	group := CRGroup new.
	
	aArray do: [:model | 
		group addAll: (self nodesFromModel: model).
	].
	
	^ group
]

{ #category : #accessing }
CRGroup >> removeAllHighlights [
"I remove all highlights from all my nodes."
	highlightedNode := nil.
	self do: [:n | n removeHighlight]
]

{ #category : #accessing }
CRGroup >> removeHighlights [
"I remove the highlight from the node that was last highlighted"
	highlightedNode ifNotNil: [ highlightedNode removeHighlight].
	highlightedNode := nil.
]
