Class {
	#name : #CRClassBlueprintBuilder,
	#superclass : #CRShapeBuilder,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRClassBlueprintBuilder >> createShapeFor: obj [
	| mondrian methods instance initialization implementor accessor attribute coll shape |
	methods := obj methods.
	
	initialization := OrderedCollection new.
	instance := OrderedCollection new.
	implementor := OrderedCollection new.
	accessor := OrderedCollection new.
	attribute := obj slots.

	coll := OrderedCollection new.
	coll add: initialization.
	coll add: instance.
	coll add: implementor.
	coll add: accessor.
	coll add: attribute.
	
	methods do: [ :method |
		"something ..."
		accessor add: method.
		instance add: method.
		implementor add: method.
		initialization add: method.
	].
	
	shape := CRClassBlueprintCanvas new.
	shape model: obj.
	
	coll do: [:c | | m |
		m := CRMondrian new.
		m nodes box
			toolTip: #name;
			with: c.
		shape addContainer: (m createCanvas canvasAsNode).
	].
	
	^shape
	

]

{ #category : #accessing }
CRClassBlueprintBuilder >> test [
<gtExample>
| c init instance implementor accessor attribute label |

c := BlElement new
	border: (BlBorder paint: Color red width: 1);
	size: (140@240);
	
	clipChildren: false.
c properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).
			
			
			
label := CRLabel new
	text: 'Class Name' asRopedText.
label constraintsDo: [ :con |
		con grid horizontal span: 5.
		con grid horizontal alignCenter  ].

init := BlElement new
	size: 100@200;
	border: (BlBorder paint: Color black width: 0.5).			
			
instance := BlElement new
	size: 100@200;
	border: (BlBorder paint: Color black width: 0.5).
	
implementor := BlElement new
	size: 100@200;
	border: (BlBorder paint: Color black width: 0.5).

accessor := BlElement new
	size: 100@200;
	border: (BlBorder paint: Color black width: 0.5).
	
attribute := BlElement new
	size: 100@200;
	border: (BlBorder paint: Color black width: 0.5).

c addChild: label.
c addChild: init.
c addChild: instance.
c addChild: implementor.
c addChild: accessor.
c addChild: attribute.
c layout: (BlGridLayout new columnCount: 5; cellSpacing: 20).
^c
]
