Class {
	#name : #CRShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'normalizerCollection',
		'modelCollection'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRShapeBuilder >> applyNormalizer: someNodes [
	normalizerCollection do: [:normalizer |
		normalizer nodes: someNodes.
		normalizer evaluateScope.
		normalizer normalize.
	].
]

{ #category : #accessing }
CRShapeBuilder >> createNodes [
	| nodes |
	
	self assert: [modelCollection isCollection] description: 'You need to provide a collection'.
	nodes := self shapesOn: modelCollection.
	self applyNormalizer: nodes.
	
	^nodes
]

{ #category : #accessing }
CRShapeBuilder >> createShapeFor: obj [
	^self subclassResponsibility
]

{ #category : #accessing }
CRShapeBuilder >> evaluate: aBlockClosure on: aObject [
" checks wheter the given Block is a Block or if it's just a value "
	(aBlockClosure class = BlockClosure) 
		ifTrue: [^ (aBlockClosure cull: aObject)]
		ifFalse: [^aBlockClosure]
]

{ #category : #accessing }
CRShapeBuilder >> initialize [
	super initialize.
	normalizerCollection := OrderedCollection new.
	^self
]

{ #category : #accessing }
CRShapeBuilder >> shapesOn: someObjects [
	| group |
	
	group := CRGroup new.
	group addAll: (someObjects collect: [ :obj | 
		self createShapeFor: obj
		]).
		
	^ group
]

{ #category : #accessing }
CRShapeBuilder >> with: aCollection [
	self assert: [aCollection isCollection] description: 'You need to provide a collection'.
	modelCollection := aCollection
]
