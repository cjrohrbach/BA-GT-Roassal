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
	mondrian build.
	result := mondrian getCanvas canvasAsNode.
	result model: obj.
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
