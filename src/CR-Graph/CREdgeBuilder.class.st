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

{ #category : #accessing }
CREdgeBuilder class >> newWithMondrian: aMondrian [
	| instance | 
	instance := CREdgeBuilder new .
	instance mondrian: aMondrian.
	instance line.
	^instance
]

{ #category : #accessing }
CREdgeBuilder >> arrow [
	edgeShape := CRArrowElement.
	toAnchorPosition := BlElementTopCenterAnchor.
]

{ #category : #accessing }
CREdgeBuilder >> color: aColor [
	color := aColor
]

{ #category : #accessing }
CREdgeBuilder >> connectFrom: aBlockOrASymbol [
	| edge |
	edge := CREdgeFrom new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : #accessing }
CREdgeBuilder >> connectFromAll: aBlockOrASymbol [
	| edge |
	edge := CREdgeFromAll new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : #accessing }
CREdgeBuilder >> connectTo: aBlockOrASymbol [
	| edge |
	edge := CREdgeToAll new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : #accessing }
CREdgeBuilder >> connectToAll: aBlockOrASymbol [
	| edge |
	edge := CREdgeToAll new.
	edge connectionBlock: aBlockOrASymbol.
	
	self passAttributesToEdge: edge.
	
	mondrian addEdgeBuilder: edge.
	^edge
]

{ #category : #accessing }
CREdgeBuilder >> initiailze [
	super initialize.
	self line.
	^self
]

{ #category : #accessing }
CREdgeBuilder >> line [
	edgeShape := CRLineElement
]

{ #category : #accessing }
CREdgeBuilder >> mondrian: aMondrian [
	mondrian := aMondrian
]

{ #category : #accessing }
CREdgeBuilder >> passAttributesToEdge: aEdge [
	width ifNotNil: [aEdge width: width].
	color ifNotNil: [aEdge color: color].
	aEdge edgeShape: edgeShape.
	toAnchorPosition ifNotNil: [aEdge toAnchorPosition: toAnchorPosition].
	fromAnchorPosition ifNotNil: [aEdge fromAnchorPosition: fromAnchorPosition].
]

{ #category : #accessing }
CREdgeBuilder >> width: aValue [
	width := aValue
]
