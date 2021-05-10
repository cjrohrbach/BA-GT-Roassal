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
		'scopeBuilderCollection',
		'isBuilt'
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
	isBuilt ifFalse: [
		canvas paint.
		self applyLayout.
		"canvas createInteractableElement."
		isBuilt := true.
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
CRMondrian >> getCanvas [
	^canvas
]

{ #category : #accessing }
CRMondrian >> getCanvasAsBlElement [
	self build.
	^canvas asElement
]

{ #category : #accessing }
CRMondrian >> gtCanvasViewOn: aView [
	<gtView>
	self build.
	^ aView explicit 
		title: 'Canvas';
		priority: 5;
		stencil: [
			canvas canvasForView];
		actionStencil: [ 
			BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons actualsize asElement;
				label: 'Zoom to fit' asRopedText;
				action: [ canvas zoomToFit ] ];
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomin asElement;
				label: 'Zoom In' asRopedText;
				action: [ canvas zoomIn ] ];
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomout asElement;
				label: 'Zoom Out' asRopedText;
				action: [ canvas zoomOut ] ]
]

{ #category : #accessing }
CRMondrian >> initialize [
	super initialize.
	nodesForLayout := CRGroup new.
	
	scopeBuilderCollection := OrderedCollection new.
	layoutBuilder := CRLayoutBuilder new.
	
	
	canvas := CRCanvas2 new.
	canvas setNodeGroup: nodesForLayout. 
	
	edgeBuilder := CREdgeBuilder new
		canvas: canvas.
	
	isBuilt := false.

	
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
