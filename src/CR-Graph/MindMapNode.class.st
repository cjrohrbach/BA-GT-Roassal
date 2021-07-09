Class {
	#name : #MindMapNode,
	#superclass : #Object,
	#instVars : [
		'model',
		'children',
		'parent',
		'isRoot',
		'depth'
	],
	#category : #'CR-Graph-MindMap'
}

{ #category : #accessing }
MindMapNode >> addChild: nodeModel [
	| c |
	c := MindMapNode new model: nodeModel; parent: self.
	children add: c.
	^c
]

{ #category : #accessing }
MindMapNode >> addChildren: mindMapNodeCollection [
	mindMapNodeCollection do: [:n | n parent: self. children add: n.]
]

{ #category : #accessing }
MindMapNode >> addChildrenFromModels: modelCollection [
	modelCollection do: [:m |
		children add: (MindMapNode new model: m; parent: self).
	]
]

{ #category : #accessing }
MindMapNode >> children [ 
	| coll |
	coll := children flatCollect: [:c | c children].
	coll add: self.
	^coll
]

{ #category : #accessing }
MindMapNode >> deepestChild [
	| dc |
	dc := self.
	children do: [:c | |temp|
		temp := c deepestChild.
		((temp depth)>dc depth) ifTrue: [dc := temp].
	].
	^dc
]

{ #category : #accessing }
MindMapNode >> depth [
	^depth
]

{ #category : #accessing }
MindMapNode >> getChildren [
	^children
]

{ #category : #accessing }
MindMapNode >> hasChildren [ 
	^children size = 0
]

{ #category : #accessing }
MindMapNode >> initialize [
	super initialize.
	children := OrderedCollection new.
	depth := 0.
	^self 
]

{ #category : #accessing }
MindMapNode >> isRoot [
	isRoot := true. 
	parent := self
]

{ #category : #accessing }
MindMapNode >> model [
	^model
]

{ #category : #accessing }
MindMapNode >> model: nodeModel [
	model := nodeModel
]

{ #category : #accessing }
MindMapNode >> parent [
	^parent
]

{ #category : #accessing }
MindMapNode >> parent: aMindMapNode [
	parent := aMindMapNode.
	self updateDepth.
]

{ #category : #accessing }
MindMapNode >> updateDepth [
	depth := (parent depth + 1).
	 children do: [:c | c updateDepth].
]
