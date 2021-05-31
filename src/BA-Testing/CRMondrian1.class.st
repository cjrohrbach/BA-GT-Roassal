"
I'm a simple API to generate some visualizations with nodes and edges.
"
Class {
	#name : #CRMondrian1,
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
	#category : #'BA-Testing-toDeleteLater'
}

{ #category : #accessing }
CRMondrian1 >> addNodesToLayout: aCRGroup [
	nodesForLayout addAll: aCRGroup
]

{ #category : #accessing }
CRMondrian1 >> allNodes [
	^allNodes
]

{ #category : #accessing }
CRMondrian1 >> applyLayout [
	layoutBuilder on: canvas
]

{ #category : #accessing }
CRMondrian1 >> build [
	isBuilt ifFalse: [
		canvas paint.
		self applyLayout.
		"canvas createInteractableElement."
		isBuilt := true.
	]
	
]

{ #category : #accessing }
CRMondrian1 >> edge [
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
CRMondrian1 >> edges: aToBlock [
	edges := edgeBuilder connectTo: aToBlock.
	^edges
]

{ #category : #accessing }
CRMondrian1 >> getCanvas [
	^canvas
]

{ #category : #accessing }
CRMondrian1 >> gtCanvasViewOn: aView [
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
CRMondrian1 >> initialize [
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
CRMondrian1 >> layout [
	^ layoutBuilder
]

{ #category : #accessing }
CRMondrian1 >> nodes [
	| scopeBuilder |
	scopeBuilder := CRShapeBuilderBuilder new.
	scopeBuilder mondrian: self.
	scopeBuilderCollection add: scopeBuilder.
	^ scopeBuilder
]
