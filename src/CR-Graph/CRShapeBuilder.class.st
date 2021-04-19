Class {
	#name : #CRShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'scopeBuilder',
		'normalizerCollection'
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

{ #category : #initialization }
CRShapeBuilder >> initializeWithScope: aScopeBuilder [
	self initialize.
	scopeBuilder := aScopeBuilder.
	^self
]

{ #category : #accessing }
CRShapeBuilder >> scopeBuilder: aCRScopeBuilder [
	scopeBuilder := aCRScopeBuilder
]

{ #category : #accessing }
CRShapeBuilder >> shapesOn: someObjects [
	| result group |
	
	group := CRGroup new.
	group addAll: (someObjects collect: [ :obj | 
		self createShapeFor: obj
		]).
		
	^ group
]

{ #category : #accessing }
CRShapeBuilder >> with: aCollection [
	| nodes |
	self assert: [aCollection isCollection] description: 'You need to provide a collection'.
	nodes := self shapesOn: aCollection.
	
	self applyNormalizer: nodes.
	
	scopeBuilder addInstancesToMondrian: nodes.
]
