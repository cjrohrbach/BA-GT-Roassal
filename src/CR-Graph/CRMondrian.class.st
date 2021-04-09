"
I'm a simple API to generate some visualizations with nodes and edges.
"
Class {
	#name : #CRMondrian,
	#superclass : #Object,
	#instVars : [
		'nodesForLayout',
		'shapeBuilder',
		'layoutBuilder',
		'depth',
		'canvas',
		'edges',
		'edgeBuilder'
	],
	#category : #'CR-Graph'
}

{ #category : #accessing }
CRMondrian >> applyLayout [
	layoutBuilder on: canvas
]

{ #category : #accessing }
CRMondrian >> build [
	self applyLayout.
]

{ #category : #accessing }
CRMondrian >> edge [
	edgeBuilder nodes: nodesForLayout.
	^ edgeBuilder
]

{ #category : #accessing }
CRMondrian >> edges: aToBlock [
	edges := edgeBuilder connectTo: aToBlock.
	^edges
]

{ #category : #accessing }
CRMondrian >> gtCanvasViewOn: aView [
	<gtView>
	^ aView explicit 
		title: 'Canvas';
		priority: 5;
		stencil: [
			self build.
			canvas asPannableElement].
]

{ #category : #accessing }
CRMondrian >> gtLiveViewOn: aView [
	<gtView>
	self build.
	^ (canvas asPannableElement) gtLiveFor: aView
]

{ #category : #accessing }
CRMondrian >> initialize [
	super initialize.
	shapeBuilder := CRShapeBuilder new.
	layoutBuilder := CRLayoutBuilder new.
	canvas := CRCanvas new. 
	edgeBuilder := CREdgeBuilder new
		canvas: canvas.
	
	nodesForLayout := CRGroup new.
	depth := 0.
	
]

{ #category : #accessing }
CRMondrian >> layout [
	^ layoutBuilder
]

{ #category : #accessing }
CRMondrian >> nodes: aCollection [
	| nodes |
	self assert: [aCollection isCollection] description: 'You need to provide a collection'.
	nodes := self shapesOn: aCollection .
	canvas addAllNodes: nodes.
	nodesForLayout addAll: nodes.
	^ nodes
]

{ #category : #accessing }
CRMondrian >> shape [
	^ shapeBuilder
]

{ #category : #accessing }
CRMondrian >> shapesOn: aCollection [ 
	| shape |
	shape := shapeBuilder shapesOn: aCollection. 
	^ shape
]
