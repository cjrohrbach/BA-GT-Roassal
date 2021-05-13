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
	result model: mondrian.
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
