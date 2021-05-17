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
	| result mondrian |
	
	mondrian := mondrianStencil cull: obj.
	mondrian.
	result := mondrian createCanvas canvasAsNode.
	result model: obj.
	toolTipContent ifNotNil: [result toolTipContent: (self evaluate: toolTipContent on: obj)].
	^ result
]

{ #category : #accessing }
CRMondrianAsNode >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRMondrianAsNode >> stencil: aBlockWithAMondrianStencil [
	mondrianStencil := aBlockWithAMondrianStencil.
	^self
]
