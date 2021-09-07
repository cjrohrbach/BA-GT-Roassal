"
I am used to create the edge Builders
"
Class {
	#name : 'CREdgeBuilderBuilder',
	#superclass : 'Object',
	#instVars : [
		'mondrian',
		'color',
		'width',
		'edgeShape',
		'toAnchorPosition',
		'fromAnchorPosition',
		'condition',
		'noHighlights',
		'highlightColor',
		'highlightWidth'
	],
	#category : 'CR-Graph-CR-Graph'
}

{ #category : 'initialization' }
CREdgeBuilderBuilder class >> newWithMondrian: aMondrian [
"I create a new instance and set the given mondrian as mondrian "
	| instance | 
	instance := CREdgeBuilderBuilder new .
	instance mondrian: aMondrian.
	instance line.
	^instance
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> arrow [
"I change the shape of the edges to arrows"
	edgeShape := CRArrowElement.
	"toAnchorPosition := BlElementTopCenterAnchor."
	toAnchorPosition := BlNearestPositionBoundsAnchor.
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> color: aColor [
"I am a setter method for the color"
	color := aColor
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> connectFrom: aBlockOrASymbol [
"	
	I create a new CREdgeFrom wich will create an edge from the block result to the given node. 
	This CREdgeFrom I'll add to the mondrian instance
"
	| edge |
	edge := CREdgeBuilderFrom new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> connectFromAll: aBlockOrASymbol [
"	
	I create a new CREdgeFromAll wich will create edges to the node from all nodes that match the block results. 
	This CREdgeFromAll I'll add to the mondrian instance
"
	| edge |
	edge := CREdgeBuilderFromAll new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> connectTo: aBlockOrASymbol [
"	
	I create a new CREdgeTo wich will create an edge to the block result from the given node. 
	This CREdgeTo I'll add to the mondrian instance
"
	| edge |
	edge := CREdgeBuilderTo new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> connectToAll: aBlockOrASymbol [
"	
	I create a new CREdgeToAll wich will create edges from the node to all nodes that match the block results. 
	This CREdgeToAll I'll add to the mondrian instance
"
	| edge |
	edge := CREdgeBuilderToAll new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> forAll: aTrueFalseBlock [
"I am a setter for the condition. The edges are only created for nodes that return true with the block"
	condition := aTrueFalseBlock
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> highlightColor: aColor [
"set the color used to highlight edges when hovered over fromNode"
	highlightColor := aColor
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> highlightWidth: aNumber [
"set the color used to highlight edges when hovered over fromNode"
	highlightWidth := aNumber
]

{ #category : 'initialization' }
CREdgeBuilderBuilder >> initialize [
	super initialize.
	self line.
	noHighlights := false.
	^self
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> line [
"I change the shape of the edges to lines"
	edgeShape := CRLineElement
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> mondrian: aMondrian [
"I am a setter method for the mondrian instance"
	mondrian := aMondrian
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> noHighlights [
"remove all highlights when hovering over connected nodes"
	noHighlights := true.
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> passAttributesToEdge: aEdge [
"I pass all the provided and stored specifications to the edge"
	width ifNotNil: [aEdge width: width].
	color ifNotNil: [aEdge color: color].
	aEdge edgeShape: edgeShape.
	toAnchorPosition ifNotNil: [aEdge toAnchorPosition: toAnchorPosition].
	fromAnchorPosition ifNotNil: [aEdge fromAnchorPosition: fromAnchorPosition].
	condition ifNotNil: [aEdge condition: condition].
	noHighlights ifTrue: [aEdge noHighlights].
	highlightColor ifNotNil: [aEdge highlightColor: highlightColor].
	highlightWidth ifNotNil: [aEdge highlightWidth: highlightWidth].
	
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> sigmoid [
"I change the shape of the edges to sigmoid"
	edgeShape := CRSigmoidElement.
]

{ #category : 'accessing' }
CREdgeBuilderBuilder >> width: aValue [
"I am a setter method for the width "
	width := aValue
]
