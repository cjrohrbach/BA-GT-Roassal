Class {
	#name : #'GR_NodeShapeBuilder',
	#superclass : #Object,
	#instVars : [
		'shape',
		'color',
		'size',
		'colorOnHover'
	],
	#category : #'GT-Roassal-GT-Roassal'
}

{ #category : #accessing }
GR_NodeShapeBuilder >> addToolTip: labelText [
	| label |
	label := [BrLabel new 
		look: BrGlamorousLabelLook new  
			glamorousRegularFontAndSize;
			alignCenter;
			text: labelText].
		
	shape look: (BrGlamorousWithTooltipLook new
		showDelay: 0;
		hideDelay: 0;
		contentStencil: label).
]

{ #category : #accessing }
GR_NodeShapeBuilder >> clone [
	| clonedElement |
	clonedElement := super clone.
	clonedElement setShape: (shape clone).
]

{ #category : #accessing }
GR_NodeShapeBuilder >> color [
	^ color
]

{ #category : #accessing }
GR_NodeShapeBuilder >> color: aColor [
	color := aColor.
	shape background: aColor.
]

{ #category : #accessing }
GR_NodeShapeBuilder >> colorOnHover [
	^colorOnHover
]

{ #category : #accessing }
GR_NodeShapeBuilder >> colorOnHover: aColor [
	colorOnHover := aColor
]

{ #category : #accessing }
GR_NodeShapeBuilder >> customShape: aBlElement [
	shape := aBlElement
]

{ #category : #accessing }
GR_NodeShapeBuilder >> getElement [
	^ GR_NodeElement new
		geometry: (shape geometry);
		background: (shape background);
		border: (shape border);
		size: size.
]

{ #category : #accessing }
GR_NodeShapeBuilder >> getElement: labelText toolTip: showToolTip hoverEffect: useHover [
	| el |
	el := GR_NodeElement new
		geometry: (shape geometry);
		background: (shape background);
		border: (shape border);
		size: size.
	
	showToolTip ifTrue: [el addToolTip: labelText].
	useHover ifTrue: [el addHoverEffekt: color effectColor: colorOnHover].
	
	^el 
]

{ #category : #accessing }
GR_NodeShapeBuilder >> initialize [
	size := 10@10.
	colorOnHover := Color green.
	self shape: #square.
	^ self
]

{ #category : #accessing }
GR_NodeShapeBuilder >> shape [
	^shape
]

{ #category : #accessing }
GR_NodeShapeBuilder >> shape: aShape [
| dict |
	dict := {
		#square ->(BlElement new
			geometry: (BlRectangle cornerRadius: 1);
			background: Color black;
			size: 10@10).
		#circle ->(BlElement new 
			geometry: BlEllipseGeometry new;
			border: (BlBorder paint: Color black width: 2);
			size: 10 asPoint).
		#point ->(BlElement new 
			geometry: BlEllipseGeometry new;
			background: Color black;
			size: 10 asPoint).
	} asDictionary.
	
	shape := dict at: aShape.
]

{ #category : #accessing }
GR_NodeShapeBuilder >> size: aSize [
	size := aSize.
	shape size: aSize.
]
