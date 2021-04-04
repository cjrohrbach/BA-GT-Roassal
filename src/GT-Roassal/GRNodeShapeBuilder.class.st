Class {
	#name : #GRNodeShapeBuilder,
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
GRNodeShapeBuilder >> addToolTip: labelText [
	| label |
	label := [BrLabel new 
		aptitude: BrGlamorousLabelAptitude new  
			glamorousRegularFontAndSize;
			alignCenter;
			text: labelText].
		
	shape aptitude: (BrGlamorousWithTooltipAptitude new
		showDelay: 0;
		hideDelay: 0;
		contentStencil: label).
]

{ #category : #accessing }
GRNodeShapeBuilder >> clone [
	| clonedElement |
	clonedElement := super clone.
	clonedElement setShape: (shape clone).
]

{ #category : #accessing }
GRNodeShapeBuilder >> color [
	^ color
]

{ #category : #accessing }
GRNodeShapeBuilder >> color: aColor [
	color := aColor.
	"shape background: aColor."
]

{ #category : #accessing }
GRNodeShapeBuilder >> colorOnHover [
	^colorOnHover
]

{ #category : #accessing }
GRNodeShapeBuilder >> colorOnHover: aColor [
	colorOnHover := aColor
]

{ #category : #accessing }
GRNodeShapeBuilder >> customShape: aBlElement [
	shape := aBlElement
]

{ #category : #accessing }
GRNodeShapeBuilder >> getElement [
	^ GRNodeElement new
		geometry: (shape geometry);
		background: (shape background);
		border: (shape border);
		size: size.
]

{ #category : #accessing }
GRNodeShapeBuilder >> getElement: labelText toolTip: showToolTip hoverEffect: useHover [
	| el |
	el := GRNodeElement new
		geometry: (shape geometry);
		background: color;
		border: (shape border);
		size: size.
	
	showToolTip ifTrue: [el addToolTip: labelText].
	useHover ifTrue: [el addHoverEffekt: color effectColor: colorOnHover].
	
	^el 
]

{ #category : #accessing }
GRNodeShapeBuilder >> initialize [
	size := 10@10.
	color := Color black.
	colorOnHover := Color green.
	self shape: #square.
	^ self
]

{ #category : #accessing }
GRNodeShapeBuilder >> shape [
	^shape
]

{ #category : #accessing }
GRNodeShapeBuilder >> shape: aShape [
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
GRNodeShapeBuilder >> size: aSize [
	size := aSize.
	shape size: aSize.
]
