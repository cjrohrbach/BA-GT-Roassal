Class {
	#name : #CRCanvas2,
	#superclass : #CRNode,
	#instVars : [
		'nodes',
		'edges'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRCanvas2 >> addAllEdges: shapeCollection [
	edges addAll: shapeCollection.
]

{ #category : #accessing }
CRCanvas2 >> addEdge: aShape [
	edges add: aShape.
]

{ #category : #accessing }
CRCanvas2 >> canvasAsNode [
	| c |
	"c := CRNode new.
	c size: 100@100.
	c clipChildren: false.
	c addChild: self.
	^c"
	self addToolTip.
	self makeDraggable.
	self openModelOnClick.
	self graph beNode.
	self border: (BlBorder paint: Color black width: 2).
	^self
]

{ #category : #accessing }
CRCanvas2 >> canvasForView [
	| c |
	c := BlZoomableElement new contentElement: self.
	c clipChildren: false.
	^ c asPannableElement
]

{ #category : #accessing }
CRCanvas2 >> initialize [
	super initializeForCanvas.
	nodes := CRGroup new.
	edges := CRGroup new.
	self properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).
	self clipChildren: false.
	^self
]

{ #category : #accessing }
CRCanvas2 >> nodeCount [
	^nodes size
]

{ #category : #accessing }
CRCanvas2 >> nodes [
	^nodes
]

{ #category : #accessing }
CRCanvas2 >> paint [
	self assert: [nodes notNil] description: 'You need to set the nodeGroup first'.
	self addChildren: nodes.
	self addChildren: edges.
]

{ #category : #accessing }
CRCanvas2 >> setEdgeGroup: aCRGroup [
	edges := aCRGroup
]

{ #category : #accessing }
CRCanvas2 >> setNodeGroup: aCRGroup [
	nodes := aCRGroup.
]
