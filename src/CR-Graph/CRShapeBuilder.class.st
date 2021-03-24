Class {
	#name : #CRShapeBuilder,
	#superclass : #Object,
	#instVars : [
		'width',
		'shapeClass',
		'height',
		'color',
		'borderWidth',
		'borderColor'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRShapeBuilder >> box [
	shapeClass := CRBox.
]

{ #category : #accessing }
CRShapeBuilder >> extent: aPoint [
	width := aPoint x.
	height := aPoint y. 
]

{ #category : #accessing }
CRShapeBuilder >> initialize [
	super initialize.
	self box.
	color := Color black.
]

{ #category : #accessing }
CRShapeBuilder >> shapeClass: aClass [
	shapeClass := aClass
]

{ #category : #accessing }
CRShapeBuilder >> shapesOn: someObjects [
	| result |
	^ someObjects collect: [ :obj | 
		result := shapeClass new.
			width ifNotNil: [result width: (width)].
			height ifNotNil: [result height: (height)].
			color ifNotNil: [result color: (color)].
			result
		] as: CRGroup
]
