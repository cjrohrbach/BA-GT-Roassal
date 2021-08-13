Class {
	#name : #MindMapStructure,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'CR-Graph-MindMap'
}

{ #category : #accessing }
MindMapStructure >> allNodesAsCollection [
"Return a collection with all mindmap nodes"
	^root children
]

{ #category : #accessing }
MindMapStructure >> deepestChild [
"return the deepest child"
	^root deepestChild
]

{ #category : #accessing }
MindMapStructure >> initialize [
	super initialize.
	
	^self 
]

{ #category : #accessing }
MindMapStructure >> root [
"Getter method for the root"
	^root
]

{ #category : #accessing }
MindMapStructure >> root: model [
"I take a model, create a MindMapNode of it and define it as my root"
	root := MindMapNode new model: model; isRoot.
	^root
]

{ #category : #accessing }
MindMapStructure >> setRootNode: mindMapNode [
"Setter method for the root"
	root := mindMapNode
]
