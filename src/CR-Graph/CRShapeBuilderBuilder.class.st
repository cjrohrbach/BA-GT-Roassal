Class {
	#name : #CRShapeBuilderBuilder,
	#superclass : #Object,
	#instVars : [
		'mondrian'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRShapeBuilderBuilder class >> newWithMondrian: aMondrian [
	| instance | 
	instance := CRShapeBuilderBuilder new .
	instance mondrian: aMondrian.
	^instance
]

{ #category : #accessing }
CRShapeBuilderBuilder >> box [
	| builder |
	builder := CRBoxBuilder new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> circle [
	| builder |
	builder := CRCircleBuilder new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> classBlueprint [
	| builder |
	builder := CRClassBlueprintBuilder new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRShapeBuilderBuilder >> label [
	| builder |
	builder := CRLabelBuilder new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> mondrian: aMondrian [
	mondrian := aMondrian
]

{ #category : #accessing }
CRShapeBuilderBuilder >> mondrianNodes [
	| builder |
	builder := CRMondrianAsNode new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> point [
	| builder |
	builder := CRPointBuilder new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> with: someCollection [ 
	"If the collection is provided without choosing the shape, the default shape is box"
	self box with: someCollection.
]
