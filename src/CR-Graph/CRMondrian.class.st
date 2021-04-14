"
I'm a simple API to generate some visualizations with nodes and edges.
"
Class {
	#name : #CRMondrian,
	#superclass : #Object,
	#instVars : [
		'nodesForLayout',
		'layoutBuilder',
		'canvas',
		'edges',
		'edgeBuilder',
		'shapeBuilderCollection'
	],
	#category : #'CR-Graph'
}

{ #category : #accessing }
CRMondrian >> addNodesToLayout: aCRGroup [
	nodesForLayout addAll: aCRGroup
]

{ #category : #accessing }
CRMondrian >> applyLayout [
	layoutBuilder on: canvas
]

{ #category : #accessing }
CRMondrian >> build [
	canvas paint.
	self applyLayout.
]

{ #category : #accessing }
CRMondrian >> customViewOn: aView [
	<gtView>
	| el |
	^ aView explicit
		title: 'Custom';
		priority: 5;
		stencil: [
			self build.
			el := BlPinchableElement new.
			el contentElement: canvas.
			el
		]
]

{ #category : #accessing }
CRMondrian >> edge [
	edgeBuilder canvas: canvas.
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
	nodesForLayout := CRGroup new.
	
	shapeBuilderCollection := OrderedCollection new.
	layoutBuilder := CRLayoutBuilder new.
	
	
	canvas := CRCanvas new.
	canvas setNodeGroup: nodesForLayout. 
	
	edgeBuilder := CREdgeBuilder new
		canvas: canvas.
	
	

	
]

{ #category : #accessing }
CRMondrian >> layout [
	^ layoutBuilder
]

{ #category : #accessing }
CRMondrian >> nodes [
	| shapeBuilder |
	shapeBuilder := CRShapeBuilder new.
	shapeBuilder mondrian: self.
	shapeBuilderCollection add: shapeBuilder.
	^ shapeBuilder
]
