"
I am a ShapeBuilder thats used to create nested mondrians
"
Class {
	#name : 'CRMondrianAsNode',
	#superclass : 'CRShapeBuilder',
	#instVars : [
		'mondrianStencil',
		'background'
	],
	#category : 'CR-Graph-ShapeBuilder'
}

{ #category : 'accessing' }
CRMondrianAsNode >> background: aValueOrAOneArgBlock [
"
	I am a setter method for the background.
	I can receive either a symbol, a block or a color.
"
	background := aValueOrAOneArgBlock.
]

{ #category : 'accessing' }
CRMondrianAsNode >> createShapeFor: obj [
"
	I create the node for the given object.
	Therfore I create a new mondrian with the given stencil
	and return the canvas of this mondrian as node.
"
	| result mondrian |
	
	mondrian := mondrianStencil cull: obj.
	mondrian.
	result := mondrian createCanvas canvasAsNode.
	background ifNotNil: [result background: (self evaluate: background on: obj)].
	^ result
]

{ #category : 'initialization' }
CRMondrianAsNode >> initialize [
	super initialize.
	^self
]

{ #category : 'accessing' }
CRMondrianAsNode >> stencil: aBlockWithAMondrianStencil [
"I am a setter method for the Stencil that should be used to create the mondrians"
	mondrianStencil := aBlockWithAMondrianStencil.
	^self
]
