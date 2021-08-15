"
A Mindmap structure consists of multiple MindMap nodes. 

{{gtExample:MindMapStructure>>#example}}
"
Class {
	#name : 'MindMapStructure',
	#superclass : 'Object',
	#instVars : [
		'root'
	],
	#category : 'CR-Graph-MindMap'
}

{ #category : 'accessing' }
MindMapStructure >> allNodesAsCollection [
"Return a collection with all mindmap nodes"
	^root children
]

{ #category : 'accessing' }
MindMapStructure >> deepestChild [
"return the deepest child"
	^root deepestChild
]

{ #category : 'accessing' }
MindMapStructure >> example [
"a simple structure as mindmap"
	<gtExample>
	|  s mi |
	^MindMapStructure new 
		root: (MindMapNode new
			model: 'Alphabet';
				addChildren: {
					MindMapNode new
						model: 'a';
						addChildrenFromModels: {'a1'. 'a2'. 'a3'. 'a4'}.
					MindMapNode new
						model: 'b';
						addChildrenFromModels: {'b1'. 'b2'. 'b3'. 'b4'}.
					MindMapNode new
						model: 'c';
						addChildrenFromModels: {'c1'. 'c2'. 'c3'. 'c4'}.
	
					};
			isRoot).

]

{ #category : 'accessing' }
MindMapStructure >> initialize [
	super initialize.
	
	^self 
]

{ #category : 'accessing' }
MindMapStructure >> root [
"Getter method for the root"
	^root
]

{ #category : 'accessing' }
MindMapStructure >> root: model [
"I take a model, create a MindMapNode of it and define it as my root"
	root := MindMapNode new model: model; isRoot.
	^root
]

{ #category : 'accessing' }
MindMapStructure >> setRootNode: mindMapNode [
"Setter method for the root"
	root := mindMapNode
]
