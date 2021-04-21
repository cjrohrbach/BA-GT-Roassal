Class {
	#name : #CRScopeBuilder,
	#superclass : #Object,
	#instVars : [
		'shapeClass',
		'nodes',
		'normalizerCollection',
		'mondrian',
		'builder'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRScopeBuilder >> addInstancesToMondrian: aCollection [
	nodes := aCollection.
	mondrian addNodesToLayout: nodes.
	^nodes
]

{ #category : #accessing }
CRScopeBuilder >> box [
	builder := CRBoxBuilder new.
	builder scopeBuilder: self.
	^ builder
]

{ #category : #accessing }
CRScopeBuilder >> circle [
	builder := CRCircleBuilder new.
	builder scopeBuilder: self.
	^ builder
]

{ #category : #accessing }
CRScopeBuilder >> createShapeFor: obj [
	^self subclassResponsibility
]

{ #category : #accessing }
CRScopeBuilder >> initialize [
	super initialize.
	normalizerCollection := OrderedCollection new.
	nodes := CRGroup new.
]

{ #category : #accessing }
CRScopeBuilder >> label [
	builder := CRLabelBuilder new.
	builder scopeBuilder: self.
	^builder
]

{ #category : #accessing }
CRScopeBuilder >> mondrian [ 
	^mondrian
]

{ #category : #accessing }
CRScopeBuilder >> mondrian: aCRMondrian [
	mondrian := aCRMondrian
]

{ #category : #accessing }
CRScopeBuilder >> nodes [
	^ nodes
]

{ #category : #accessing }
CRScopeBuilder >> point [
	builder := CRPointBuilder new.
	builder scopeBuilder: self.
	^ builder
]
