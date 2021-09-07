"
I am the shapeBuilder used for shapes according to a provided stencil


{{gtExample:CRMondrianExamples>>#customShape|previewExpanded=true|codeExpanded=true}}
"
Class {
	#name : 'CRCustomShapeBuilder',
	#superclass : 'CRShapeBuilder',
	#instVars : [
		'stencil'
	],
	#category : 'CR-Graph-ShapeBuilder'
}

{ #category : 'accessing' }
CRCustomShapeBuilder >> createShapeFor: obj [
"
	I create a node accodring to the stencil
"
| shape |
	shape := stencil cull: obj.
	^shape
]

{ #category : 'accessing' }
CRCustomShapeBuilder >> stencil: aBlock [
	"The stencil used to build all Nodes"
	stencil := aBlock.
]
