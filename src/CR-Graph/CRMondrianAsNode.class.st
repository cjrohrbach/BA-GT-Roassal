"
I am a ShapeBuilder thats used to create mondrians as node
"
Class {
	#name : #CRMondrianAsNode,
	#superclass : #CRShapeBuilder,
	#instVars : [
		'mondrianStencil'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
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
	result model: obj.
	toolTipContent ifNotNil: [result toolTipContent: (self evaluate: toolTipContent on: obj)].
	^ result
]

{ #category : #initialization }
CRMondrianAsNode >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRMondrianAsNode >> stencil: aBlockWithAMondrianStencil [
"I am a setter method for the Stencil that should be used to create the mondrians"
	mondrianStencil := aBlockWithAMondrianStencil.
	^self
]
