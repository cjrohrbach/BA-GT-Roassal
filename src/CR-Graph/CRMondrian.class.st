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
		'isBuilt',
		'allNodes'
	],
	#category : #'CR-Graph'
}

{ #category : #accessing }
CRMondrian >> addNodesToLayout: aCRGroup [
	nodesForLayout addAll: aCRGroup
]

{ #category : #accessing }
CRMondrian >> allNodes [
	^allNodes
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
	nodesForLayout do: [ :n | 
		allNodes add: n.
		(n class = CRCanvas ) ifTrue: 
		[ allNodes addAll: (n nodes)].
	].
	edgeBuilder mondrian: self.
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
CRMondrian >> gtCanvasViewOn: aView [
	<gtView>
	| canv |
	self build.
	^ aView explicit 
		title: 'Canvas';
		priority: 5;
		stencil: [
			canv := canvas canvasForView];
		actionStencil: [ 
			BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons actualsize asElement;
				label: 'Zoom to fit' asRopedText;
				action: [ canv zoomToFit ] ];
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomin asElement;
				label: 'Zoom In' asRopedText;
				action: [ canv zoomIn ] ];
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomout asElement;
				label: 'Zoom Out' asRopedText;
				action: [ canv zoomOut ] ]
]

{ #category : #accessing }
CRMondrian >> initialize [
	super initialize.
	nodesForLayout := CRBindingGroup new.
	allNodes := CRGroup new.
	
	scopeBuilderCollection := OrderedCollection new.
	layoutBuilder := CRLayoutBuilder new.
	
	
	canvas := CRCanvas new.
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
