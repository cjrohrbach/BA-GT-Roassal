Class {
	#name : #GtRoassal,
	#superclass : #GtMondrian,
	#instVars : [
		'nodeShape',
		'nodeCollection',
		'mondrianInst',
		'nodeLayout',
		'showTooltip',
		'layout'
	],
	#category : #'GT-Roassal'
}

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
GtRoassal >> circle [
	^ (BlElement new 
		geometry: BlEllipseGeometry new;
				border: (BlBorder paint: Color black width: 2);
				size: 50 asPoint)
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
			background: Color gray;
			size: 10@10].
		#circle ->[BlElement new 
			geometry: BlEllipseGeometry new;
			border: (BlBorder paint: Color black width: 2);
			size: 10 asPoint].
		#point ->[BlElement new 
			geometry: BlEllipseGeometry new;
			background: Color gray;
			size: 10 asPoint].
	} asDictionary.
	
	nodeShape := (dict at: aShape) asStencil
	
]

{ #category : #accessing }
GtRoassal >> nodes [
	nodeCollection := (1 to: 10).
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
	nodeShape := [BlElement new 
		geometry: BlEllipseGeometry new;
		border: (BlBorder paint: Color black width: 2);
		size: 50 asPoint].
	
]

{ #category : #accessing }
GtRoassal >> shape: aShape [
	| dict |
	dict := {
		#square ->[BlElement new
			geometry: (BlRectangle cornerRadius: 1);
			background: Color gray;
			size: 10@10].
		#circle ->[BlElement new 
			geometry: BlEllipseGeometry new;
			border: (BlBorder paint: Color black width: 2);
			size: 10 asPoint].
		#point ->[BlElement new 
			geometry: BlEllipseGeometry new;
			background: Color gray;
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
