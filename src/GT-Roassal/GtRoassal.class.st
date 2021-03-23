Class {
	#name : #GtRoassal,
	#superclass : #Object,
	#instVars : [
		'nodeCollection',
		'mondrianInst',
		'nodeLayout',
		'showTooltip',
		'layout',
		'nodeShapeBuilder',
		'hoverColor',
		'hoverEffect'
	],
	#category : #'GT-Roassal'
}

{ #category : #accessing }
GtRoassal >> _build [
	| tmp |
	mondrianInst nodes
		shape: [ :x | 
			(nodeShapeBuilder getElement: x toolTip: showTooltip hoverEffect: hoverEffect)];
		with: (nodeCollection).
	self setLayout.
]

{ #category : #accessing }
GtRoassal >> _color: aColor [
	nodeShapeBuilder color: aColor
]

{ #category : #accessing }
GtRoassal >> _customShape: aBlElement [
	nodeShapeBuilder customShape: aBlElement
]

{ #category : #accessing }
GtRoassal >> _shape: aShape [
	nodeShapeBuilder shape: aShape
]

{ #category : #accessing }
GtRoassal >> _size: aSize [
	nodeShapeBuilder size: aSize
]

{ #category : #accessing }
GtRoassal >> addHoverEffect: aColor [
	hoverEffect := true.
	nodeShapeBuilder colorOnHover: aColor.
]

{ #category : #accessing }
GtRoassal >> edges [
	^ mondrianInst edges
]

{ #category : #ui }
GtRoassal >> gtLiveFor: aView [
	<gtView>
	^ mondrianInst gtLiveFor: aView
]

{ #category : #accessing }
GtRoassal >> hoverColor [
	^nodeShapeBuilder colorOnHover
]

{ #category : #accessing }
GtRoassal >> hoverEffect [
	^ hoverEffect
]

{ #category : #accessing }
GtRoassal >> initialize [
	showTooltip := true.
	hoverEffect := false.
	nodeLayout := #grid.
	nodeShapeBuilder := GR_NodeShapeBuilder new.
	mondrianInst := GtMondrian new.
	^ self
]

{ #category : #accessing }
GtRoassal >> layout [ 
	^ mondrianInst layout
]

{ #category : #accessing }
GtRoassal >> layout: aLayout [
	nodeLayout := aLayout.
]

{ #category : #accessing }
GtRoassal >> nodes [
	^ nodeCollection.
]

{ #category : #accessing }
GtRoassal >> nodes: aCollection [
	nodeCollection := aCollection.
]

{ #category : #accessing }
GtRoassal >> setLayout [
	(nodeLayout = #grid) ifTrue: [mondrianInst layout grid] 
		ifFalse: [
	(nodeLayout = #circle) ifTrue: [mondrianInst layout circle]
		ifFalse: [
	(nodeLayout = #tree) ifTrue: [mondrianInst layout tree]]].
	
]

{ #category : #accessing }
GtRoassal >> showTooltip [
	^ showTooltip
]

{ #category : #accessing }
GtRoassal >> showTooltip: aBoolean [
	showTooltip := aBoolean.
]

{ #category : #accessing }
GtRoassal >> stack [
	^ mondrianInst stack
]
