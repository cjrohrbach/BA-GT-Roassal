Class {
	#name : #CREdgeBuilder,
	#superclass : #Object,
	#instVars : [
		'mondrian',
		'color',
		'width',
		'edgeShape',
		'toAnchorPosition',
		'fromAnchorPosition'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #initialization }
CREdgeBuilder class >> newWithMondrian: aMondrian [
"I create a new instance and set the given mondrian as mondrian "
	| instance | 
	instance := CREdgeBuilder new .
	instance mondrian: aMondrian.
	instance line.
	^instance
]

{ #category : #accessing }
CREdgeBuilder >> arrow [
"I change the shape of the edges to arrows"
	edgeShape := CRArrowElement.
	toAnchorPosition := BlElementTopCenterAnchor.
]

{ #category : #accessing }
CREdgeBuilder >> color: aColor [
"I am a setter method for the color"
	color := aColor
]

{ #category : #accessing }
CREdgeBuilder >> connectFrom: aBlockOrASymbol [
"	
	I create a new CREdgeFrom wich will create an edge from the block result to the given node. 
	This CREdgeFrom I'll add to the mondrian instance
"
	| edge |
	edge := CREdgeFrom new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : #accessing }
CREdgeBuilder >> connectFromAll: aBlockOrASymbol [
"	
	I create a new CREdgeFromAll wich will create edges to the node from all nodes that match the block results. 
	This CREdgeFromAll I'll add to the mondrian instance
"
	| edge |
	edge := CREdgeFromAll new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : #accessing }
CREdgeBuilder >> connectTo: aBlockOrASymbol [
"	
	I create a new CREdgeTo wich will create an edge to the block result from the given node. 
	This CREdgeTo I'll add to the mondrian instance
"
	| edge |
	edge := CREdgeToAll new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : #accessing }
CREdgeBuilder >> connectToAll: aBlockOrASymbol [
"	
	I create a new CREdgeToAll wich will create edges from the node to all nodes that match the block results. 
	This CREdgeToAll I'll add to the mondrian instance
"
	| edge |
	edge := CREdgeToAll new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : #initialization }
CREdgeBuilder >> initiailze [
	super initialize.
	self line.
	^self
]

{ #category : #accessing }
CREdgeBuilder >> line [
"I change the shape of the edges to lines"
	edgeShape := CRLineElement
]

{ #category : #accessing }
CREdgeBuilder >> mondrian: aMondrian [
"I am a setter method for the mondrian instance"
	mondrian := aMondrian
]

{ #category : #accessing }
CREdgeBuilder >> passAttributesToEdge: aEdge [
"I pass all the provided and stored specifications to the edge"
	width ifNotNil: [aEdge width: width].
	color ifNotNil: [aEdge color: color].
	aEdge edgeShape: edgeShape.
	toAnchorPosition ifNotNil: [aEdge toAnchorPosition: toAnchorPosition].
	fromAnchorPosition ifNotNil: [aEdge fromAnchorPosition: fromAnchorPosition].
]

{ #category : #accessing }
CREdgeBuilder >> width: aValue [
"I am a setter method for the width "
	width := aValue
]
