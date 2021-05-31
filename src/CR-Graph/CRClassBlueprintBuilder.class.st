Class {
	#name : #CRClassBlueprintBuilder,
	#superclass : #CRShapeBuilder,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRClassBlueprintBuilder >> createShapeFor: obj [
	| mondrian methods interface initialization implementor accessor attribute coll shape |
	methods := obj methods.
	methods addAll: obj class methods.
	
	initialization := CRGroup new name: 'initialization'.
	interface := CRGroup new name: 'interface'.
	implementor := CRGroup new name: 'implementor'.
	accessor := CRGroup new name: 'accessor'.
	attribute := CRGroup new name: 'attribute'.
	
	attribute addAll: obj slots.

	coll := OrderedCollection new.
	coll add: initialization.
	coll add: interface.
	coll add: implementor.
	coll add: accessor.
	coll add: attribute.
	
	methods do: [ :method |
		
		(method isAccessor or: method isSetter) ifTrue: [accessor add: method]
		ifFalse: [
			(method isInitialization) ifTrue: [initialization add: method]
				ifFalse: [
					(method isPrivateIn: modelCollection) ifTrue: [implementor add: method]
						ifFalse: [
							interface add: method.
						].
				].
		].
	].
	
	shape := CRClassBlueprintCanvas new.
	shape model: obj.
	
	coll do: [:c | | m canv |
		m := CRMondrian new.
		m nodes box
			toolTip: #name;
			with: c.
		
		canv := m createCanvas canvasAsNode toolTipContent: c name.
			
		shape addContainer: (canv).
	].
	
	^shape
	

]

{ #category : #accessing }
CRClassBlueprintBuilder >> test [
"I hold an example of the layout with a label and 5 conatainers. I should be moved or removed later on"
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
