Class {
	#name : #CRCanvas,
	#superclass : #Object,
	#instVars : [
		'shapes',
		'canvas',
		'layout'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRCanvas >> add: aShape [
	shapes add: aShape.
	canvas addChild: aShape
]

{ #category : #accessing }
CRCanvas >> addAll: shapeCollection [
	shapes addAll: shapeCollection.
	canvas addChildren: shapeCollection.
]

{ #category : #accessing }
CRCanvas >> asPannableElement [
	^canvas asPannableElement
]

{ #category : #accessing }
CRCanvas >> initialize [
	super initialize.
	shapes := CRGroup new.
	canvas := BlElement new.
	canvas properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).
]

{ #category : #accessing }
CRCanvas >> layout: aLayout [
	canvas layout: aLayout.
]

{ #category : #accessing }
CRCanvas >> shapeCount [
	^shapes size
]
