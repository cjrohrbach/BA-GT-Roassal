Class {
	#name : #CRCustomShapeBuilder,
	#superclass : #CRShapeBuilder,
	#instVars : [
		'stencil'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRCustomShapeBuilder >> createShapeFor: obj [
"
	I create a node accodring to the stencil
"
| result |
	result := stencil cull: obj.
	result model: obj.
	^result
]

{ #category : #accessing }
CRCustomShapeBuilder >> stencil: aBlock [
	"The stencil used to build all Nodes"
	stencil := aBlock.
]
