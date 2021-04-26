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
		'scopeBuilderCollection'
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
	self build.
	^ aView explicit 
		title: 'Canvas';
		priority: 5;
		stencil: [
			canvas asPannableElement].
]

{ #category : #accessing }
CRMondrian >> initialize [
	super initialize.
	nodesForLayout := CRGroup new.
	
	scopeBuilderCollection := OrderedCollection new.
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
	| scopeBuilder |
	scopeBuilder := CRScopeBuilder new.
	scopeBuilder mondrian: self.
	scopeBuilderCollection add: scopeBuilder.
	^ scopeBuilder
]
