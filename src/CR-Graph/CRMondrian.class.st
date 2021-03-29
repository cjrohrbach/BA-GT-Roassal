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
CRMondrian >> gtInspectorView: aView [
	<gtView>
	^ aView explicit
		title: 'Canvas';
		priority: 50;
		initialize: [self build]
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
CRMondrian >> shape: aCRShape [
	shapeBuilder shape
]

{ #category : #accessing }
CRMondrian >> shapesOn: aCollection [ 
	| shape |
	shape := shapeBuilder shapesOn: aCollection. 
	^ shape
]
