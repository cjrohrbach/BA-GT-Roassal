"
I am a node within a mindmap strucutre.
I have a parent node as well as children nodes.
"
Class {
	#name : 'MindMapNode',
	#superclass : 'Object',
	#instVars : [
		'model',
		'children',
		'parent',
		'isRoot',
		'depth'
	],
	#category : 'CR-Graph-MindMap'
}

{ #category : 'accessing' }
MindMapNode >> addChild: nodeModel [
"Create a new mindmap node from the model and add it as child"
	| c |
	c := MindMapNode new model: nodeModel; parent: self.
	children add: c.
	^c
]

{ #category : 'accessing' }
MindMapNode >> addChildren: mindMapNodeCollection [
"Add the collection of mindmap nodes as children"
	mindMapNodeCollection do: [:n | n parent: self. children add: n.]
]

{ #category : 'accessing' }
MindMapNode >> addChildrenFromModels: modelCollection [
"Create child mindmap nodes from the given collection of models"
	modelCollection do: [:m |
		children add: (MindMapNode new model: m; parent: self).
	]
]

{ #category : 'accessing' }
MindMapNode >> children [ 
"Getter method for all children and their children"
	| coll |
	coll := children flatCollect: [:c | c children].
	coll add: self.
	^coll
]

{ #category : 'accessing' }
MindMapNode >> deepestChild [
"Return my deepest child"
	| dc |
	dc := self.
	children do: [:c | |temp|
		temp := c deepestChild.
		((temp depth)>dc depth) ifTrue: [dc := temp].
	].
	^dc
]

{ #category : 'accessing' }
MindMapNode >> depth [
"Getter method for the depth"
	^depth
]

{ #category : 'accessing' }
MindMapNode >> getChildren [
"Getter method for children collection"
	^children
]

{ #category : 'accessing' }
MindMapNode >> getIsRoot [
"Return true if I am a root"
	^isRoot
]

{ #category : 'accessing' }
MindMapNode >> hasChildren [ 
"Return true if I have children"
	^children size ~= 0
]

{ #category : 'accessing' }
MindMapNode >> initialize [
	super initialize.
	children := OrderedCollection new.
	depth := 0.
	isRoot := false.
	^self 
]

{ #category : 'accessing' }
MindMapNode >> isRoot [
"Define myself as root"
	isRoot := true. 
	parent := self
]

{ #category : 'accessing' }
MindMapNode >> model [
"Getter method for model"
	^model
]

{ #category : 'accessing' }
MindMapNode >> model: nodeModel [
"Setter method for the model"
	model := nodeModel
]

{ #category : 'accessing' }
MindMapNode >> parent [
"Getter method for the parent"
	^parent
]

{ #category : 'accessing' }
MindMapNode >> parent: aMindMapNode [
"Setter method for my parent"
	parent := aMindMapNode.
	self updateDepth.
]

{ #category : 'accessing' }
MindMapNode >> updateDepth [
"Update mine and my childrens depth according to my parents depth "
	depth := (parent depth + 1).
	 children do: [:c | c updateDepth].
]
