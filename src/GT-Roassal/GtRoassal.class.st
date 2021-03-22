Class {
	#name : #GtRoassal,
	#superclass : #Object,
	#instVars : [
		'nodeShape',
		'nodeCollection',
		'mondrianInst',
		'nodeLayout',
		'showTooltip',
		'layout',
		'nodeShapeBuilder'
	],
	#category : #'GT-Roassal'
}

{ #category : #accessing }
GtRoassal >> _build [
	mondrianInst nodes
		shape: [ :x | (nodeShapeBuilder getElement) 
		addHoverEffekt: (nodeShapeBuilder color) effectColor: (Color pink);
		addToolTip: x];
		with: nodeCollection.
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
GtRoassal >> build [
	|look label|
	
	mondrianInst nodes 
		shape: [ :x | self buildNodeShape: x];
		with: nodeCollection.
	self setLayout.
]

{ #category : #accessing }
GtRoassal >> buildNodeShape: labelText [
	| shape label |
	shape := nodeShape create.
	
	showTooltip
		ifTrue: [
		
			label := [BrLabel new look: BrGlamorousLabelLook new  glamorousRegularFontAndSize;
				alignCenter;
				text: labelText].
		
			shape look: (BrGlamorousWithTooltipLook new
				showDelay: 0;
				hideDelay: 0;
				contentStencil: label)].
	
	^ shape
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
GtRoassal >> initialize [
	showTooltip := true.
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
GtRoassal >> nodeShape [
	^ nodeShape
	
]

{ #category : #accessing }
GtRoassal >> nodeShape: aShape [
	| dict |
	dict := {
		#square ->[BlElement new
			geometry: (BlRectangle cornerRadius: 1);
			background: Color black;
			size: 10@10].
		#circle ->[BlElement new 
			geometry: BlEllipseGeometry new;
			border: (BlBorder paint: Color black width: 2);
			size: 10 asPoint].
		#point ->[BlElement new 
			geometry: BlEllipseGeometry new;
			background: Color black;
			size: 10 asPoint].
	} asDictionary.
	
	nodeShape := (dict at: aShape) asStencil
	
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
GtRoassal >> shape [
	^ nodeShape
	
]

{ #category : #accessing }
GtRoassal >> shape: aShape [
	| dict |
	dict := {
		#square ->[BlElement new
			geometry: (BlRectangle cornerRadius: 1);
			background: Color black;
			size: 10@10].
		#circle ->[BlElement new 
			geometry: BlEllipseGeometry new;
			border: (BlBorder paint: Color black width: 2);
			size: 10 asPoint].
		#point ->[BlElement new 
			geometry: BlEllipseGeometry new;
			background: Color black;
			size: 10 asPoint].
	} asDictionary.
	
	nodeShape := (dict at: aShape) asStencil.
	
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
