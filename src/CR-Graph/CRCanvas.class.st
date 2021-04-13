"
I hold all nodes and edges that are displayed in a graph.
"
Class {
	#name : #CRCanvas,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'layout',
		'edges',
		'nodes'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRCanvas >> addAllEdges: shapeCollection [
	edges addAll: shapeCollection.
	canvas addChildren: shapeCollection.
]

{ #category : #accessing }
CRCanvas >> addAllNodes: shapeCollection [
	nodes addAll: shapeCollection.
	canvas addChildren: shapeCollection.
]

{ #category : #accessing }
CRCanvas >> addEdge: aShape [
	edges add: aShape.
	canvas addChild: aShape.
]

{ #category : #accessing }
CRCanvas >> addNode: aShape [
	nodes add: aShape.
	canvas addChild: aShape.
]

{ #category : #accessing }
CRCanvas >> asElement [
	^canvas
]

{ #category : #accessing }
CRCanvas >> asPannableElement [
	^canvas asPannableElement
]

{ #category : #accessing }
CRCanvas >> initialize [
	super initialize.
	nodes := CRGroup new.
	edges := CRGroup new.
	canvas := BlElement new.
	canvas properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).		
	canvas clipChildren: false.
	
]

{ #category : #accessing }
CRCanvas >> layout: aLayout [
	canvas layout: aLayout.
]

{ #category : #accessing }
CRCanvas >> nodeCount [
	^nodes size
]

{ #category : #accessing }
CRCanvas >> nodes [
	^nodes
]

{ #category : #accessing }
CRCanvas >> removeAllHighlightsOnClick [
	canvas addEventHandlerOn: BlClickEvent do: [nodes removeHighlights]
]

{ #category : #accessing }
CRCanvas >> setEdgeGroup: aCRGroup [
	edges := aCRGroup.
]

{ #category : #accessing }
CRCanvas >> setNodeGroup: aCRGroup [
	nodes := aCRGroup.
	canvas addChildren: nodes.
]

{ #category : #accessing }
CRCanvas >> shapeCount [
	^shapes size
]
