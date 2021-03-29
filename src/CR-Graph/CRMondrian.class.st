Class {
	#name : #CRMondrian,
	#superclass : #Object,
	#instVars : [
		'nodesForLayout',
		'shapeBuilder',
		'layoutBuilder',
		'depth',
		'canvas'
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
CRMondrian >> gtLiveViewOn: aView [
	<gtView>
	^ aView explicit 
		title: 'Live';
		priority: 5;
		stencil: [
			self build.
			canvas asPannableElement].
]

{ #category : #accessing }
CRMondrian >> initialize [
	super initialize.
	shapeBuilder := CRShapeBuilder new.
	layoutBuilder := CRLayoutBuilder new. 
	canvas := CRCanvas new.
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
	canvas addAll: nodes.
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
