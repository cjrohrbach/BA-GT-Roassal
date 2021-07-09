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
	^root children
]

{ #category : #accessing }
MindMapStructure >> deepestChild [
	^root deepestChild
]

{ #category : #accessing }
MindMapStructure >> deepestLeave [
	^root deepestChild
]

{ #category : #accessing }
MindMapStructure >> initialize [
	super initialize.
	
	^self 
]

{ #category : #accessing }
MindMapStructure >> root [
	^root
]

{ #category : #accessing }
MindMapStructure >> root: model [
	root := MindMapNode new model: model; isRoot.
	^root
]

{ #category : #accessing }
MindMapStructure >> setRootNode: mindMapNode [
	root := mindMapNode
]
