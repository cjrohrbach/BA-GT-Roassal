Class {
	#name : #'GR_NodeShapeBuilder',
	#superclass : #Object,
	#instVars : [
		'shape',
		'color',
		'size'
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
GR_NodeShapeBuilder >> asStencil [
	^ [BlElement new
		geometry: (shape geometry);
		background: (shape background);
		size: (shape size)] asStencil
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
GR_NodeShapeBuilder >> getStencil [
	^ [BlElement new
		geometry: BlRectangle cornerRadius: 1;
		background: Color green;
		size: 10@10].
]

{ #category : #accessing }
GR_NodeShapeBuilder >> hoverEffect [
	shape addEventHandlerOn: BlMouseEnterEvent do: [shape background: Color green].
	shape addEventHandlerOn: BlMouseLeaveEvent do: [shape background: color].
]

{ #category : #accessing }
GR_NodeShapeBuilder >> initialize [
	size := 10@10.
	self shape: #square.
	^ self
]

{ #category : #accessing }
GR_NodeShapeBuilder >> shape [
	^shape clone
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

{ #category : #accessing }
GR_NodeShapeBuilder >> toolTip: labelText [
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
