"
I am used to choose and create the ShapeBuilder
"
Class {
	#name : #CRShapeBuilderBuilder,
	#superclass : #Object,
	#instVars : [
		'mondrian'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #initialization }
CRShapeBuilderBuilder class >> newWithMondrian: aMondrian [
"I am a constructor for CRShapeBuilderBuilder. I take a Mondrian instance that gets added to the new CRShapeBuilderBuilder"
	| instance | 
	instance := CRShapeBuilderBuilder new .
	instance mondrian: aMondrian.
	^instance
]

{ #category : #accessing }
CRShapeBuilderBuilder >> box [
"I return a CRBoxBuilder to create mondrians with box nodes. I also add this builder to the mondrian instance."
	| builder |
	builder := CRBoxBuilder new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> circle [
"I return a CRCricleBuilder to create mondrians with circle nodes. I also add this builder to the mondrian instance."
	| builder |
	builder := CRCircleBuilder new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> classBlueprint [
"I return a CRClassBlueprintBuilder to create mondrians with classBlueprint nodes. I also add this builder to the mondrian instance."
	| builder |
	builder := CRClassBlueprintBuilder new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> custom [
	| builder |
	builder := CRCustomShapeBuilder new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> custom: aStencilBlock [
	| builder |
	builder := CRCustomShapeBuilder new.
	builder stencil: aStencilBlock.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #initialization }
CRShapeBuilderBuilder >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRShapeBuilderBuilder >> label [
"I return a CRLabelBuilder to create mondrians with label nodes. I also add this builder to the mondrian instance."
	| builder |
	builder := CRLabelBuilder new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> mondrian: aMondrian [
"I am a setter method for the mondrian isntance"
	mondrian := aMondrian
]

{ #category : #accessing }
CRShapeBuilderBuilder >> mondrianNodes [
"I return a CRMondrianAsNode to create mondrians with a mondrian as node. I also add this builder to the mondrian instance."
	| builder |
	builder := CRMondrianAsNode new.
	mondrian addShapeBuilder: builder.
	^builder
]

{ #category : #accessing }
CRShapeBuilderBuilder >> point [
"I return a CRPointBuilder to create mondrians with point nodes. I also add this builder to the mondrian instance."	
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
