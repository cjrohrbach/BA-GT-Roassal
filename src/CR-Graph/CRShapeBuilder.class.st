"
I represent a ShapeBuilder, and I am used to create nodes for models.
"
Class {
	#name : #CRShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'normalizerCollection',
		'modelCollection',
		'toolTipContent'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #'node-creation' }
CRShapeBuilder >> applyNormalizer: someNodes [
"I normalize all provided nodes with the normalizers that were added druing creation."
	normalizerCollection do: [:normalizer |
		normalizer nodes: someNodes.
		normalizer evaluateScope.
		normalizer normalize.
	].
]

{ #category : #'node-creation' }
CRShapeBuilder >> createNodes [
"
	I initiate the creation of the nodes with the provided collection and specifications.
	If there is no collection provided I'll raise an Error.
	The created nodes are then returend as a CRGroup.
"
	| nodes |	
	self assert: [modelCollection isCollection] description: 'You need to provide a collection'.
	
	nodes := self shapesOn: modelCollection.
	self applyNormalizer: nodes.
	
	^nodes
]

{ #category : #'node-creation' }
CRShapeBuilder >> createShapeFor: obj [
"I take an model and create and return a node matching the provided specifications. 
Therefore I have to be implemented in the subclass that holds further information about the shape.
"
	^self subclassResponsibility
]

{ #category : #'node-creation' }
CRShapeBuilder >> evaluate: aBlockClosure on: aObject [
" checks wheter the given Block is a Block or if it's just a value "
	(aBlockClosure class = BlockClosure or: aBlockClosure class = ByteSymbol) 
		ifTrue: [^ (aBlockClosure cull: aObject)]
		ifFalse: [^aBlockClosure]
]

{ #category : #initialization }
CRShapeBuilder >> initialize [
	super initialize.
	normalizerCollection := OrderedCollection new.
	^self
]

{ #category : #'node-creation' }
CRShapeBuilder >> shapesOn: someObjects [
"I create the nodes for the provided collection, using the createShapeFor method, and collect them as a CRGroup."

	| group |
	
	group := CRGroup new.
	group addAll: (someObjects collect: [ :obj | | node |
		node := CRNode_2 new
			shape:(self createShapeFor: obj);
			model: obj.
			
		toolTipContent ifNotNil: [node toolTipContent: (self evaluate: toolTipContent on: obj)].
		
		node
		]).
		
	^ group
]

{ #category : #accessing }
CRShapeBuilder >> toolTip: someValueOrBlock [
"I'm used to set the toolTipContent variable"
	toolTipContent := someValueOrBlock
]

{ #category : #accessing }
CRShapeBuilder >> with: aCollection [
"I am a setter method for the modelCollection variable which holds the models that later are used to create the nodes"
	self assert: [aCollection isCollection] description: 'You need to provide a collection'.
	modelCollection := aCollection
]
