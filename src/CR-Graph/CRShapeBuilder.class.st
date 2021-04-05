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
CRShapeBuilder >> borderColor [
	^borderColor
]

{ #category : #accessing }
CRShapeBuilder >> borderColor: aColorOrAOneArgBlock [
	borderColor := aColorOrAOneArgBlock
]

{ #category : #accessing }
CRShapeBuilder >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
CRShapeBuilder >> borderWidth: aValueOrAOneArgBlock [
	borderWidth := aValueOrAOneArgBlock
]

{ #category : #accessing }
CRShapeBuilder >> box [
	shapeClass := CRBox.
	^self
]

{ #category : #accessing }
CRShapeBuilder >> circle [
	shapeClass := CRCircle.
	^self
]

{ #category : #accessing }
CRShapeBuilder >> color [
	^color
]

{ #category : #accessing }
CRShapeBuilder >> color: aColorOrAnArgBlock [
	color := aColorOrAnArgBlock.
	^self
]

{ #category : #accessing }
CRShapeBuilder >> evaluate: aBlockClosure on: aObject [
" checks wheter the given Block is a Block or if it's just a value "
	(aBlockClosure class = BlockClosure) 
		ifTrue: [^ (aBlockClosure cull: aObject)]
		ifFalse: [^aBlockClosure]
]

{ #category : #accessing }
CRShapeBuilder >> extent: aPoint [
	width := aPoint x.
	height := aPoint y. 
	^self
]

{ #category : #accessing }
CRShapeBuilder >> height [
	^height
]

{ #category : #accessing }
CRShapeBuilder >> height: aValueOrAOneArgBlock [
	height := aValueOrAOneArgBlock.
	^self
]

{ #category : #accessing }
CRShapeBuilder >> initialize [
	super initialize.
	self box.
	^self
]

{ #category : #accessing }
CRShapeBuilder >> point [
	shapeClass := CRPoint.
	^self
]

{ #category : #accessing }
CRShapeBuilder >> shapesOn: someObjects [
	| result group |
	
	group := CRGroup new.
	group addAll: (someObjects collect: [ :obj | 
		result := shapeClass new 
			model: obj;
			group: group.
		result highlightOnClick.
		width ifNotNil: [result width: (self evaluate: width on: obj)].
		height ifNotNil: [result height: (self evaluate: height on: obj)].
		color ifNotNil: [result color: (self evaluate: color on: obj)].
		
		(borderWidth notNil and: [borderColor notNil])
			ifTrue: [result border: (BlBorder paint:(self evaluate: borderColor on: obj) width: (self evaluate: borderWidth on: obj))]
			ifFalse: [
				borderWidth ifNotNil: [result border: (BlBorder paint: Color black width: (self evaluate: borderWidth on: obj))].
				borderColor ifNotNil: [result border: (BlBorder paint: (self evaluate: borderColor on: obj) width: 4)]].
		result
		]).
		
	^ group
]

{ #category : #accessing }
CRShapeBuilder >> size: aValueOrAOneArgBlock [
	width := aValueOrAOneArgBlock.
	height := aValueOrAOneArgBlock.
	^self
]

{ #category : #accessing }
CRShapeBuilder >> width [
	^ width
]

{ #category : #accessing }
CRShapeBuilder >> width: aValueOrAOneArgBlock [
	width := aValueOrAOneArgBlock.
	^self
]
