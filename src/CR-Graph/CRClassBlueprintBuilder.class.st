"
I am a ClassBlueprint builder and I'm used to build class blueprints for the given collection
"
Class {
	#name : #CRClassBlueprintBuilder,
	#superclass : #CRShapeBuilder,
	#instVars : [
		'accessEdgeColor',
		'invocationEdgeColor',
		'getterColor',
		'setterColor',
		'interfaceLayerColor',
		'constantColor',
		'delegationColor',
		'extendingColor',
		'abstractColor',
		'attributeColor',
		'overridingColor'
	],
	#category : #'CR-Graph-ShapeBuilder'
}

{ #category : #accessing }
CRClassBlueprintBuilder >> colorMethod: aNode [
	| method |
	method := aNode model.
	(method isSubclassResponsibility) ifTrue: [
		aNode centerElement background: abstractColor.
	] ifFalse: [
		(method isExtendingMethod) ifTrue: [
			aNode centerElement background: extendingColor.
		] ifFalse: [
			(method isPureOverridingMethod) ifTrue: [
				aNode centerElement background: overridingColor.
			] ifFalse: [
				(method )
			]
		]
	]
]

{ #category : #accessing }
CRClassBlueprintBuilder >> createAttributeNodes: methods [
	| shapeBuilder |
	
	shapeBuilder := CRBoxBuilder new.
	shapeBuilder with: methods.
	shapeBuilder addNormalizer: self methodHeightNormalizer.
	shapeBuilder addNormalizer: self methodWidthNormalizer.
	
	^shapeBuilder createNodes
	
]

{ #category : #accessing }
CRClassBlueprintBuilder >> createMethodNodes: methods [
	| shapeBuilder |
	
	shapeBuilder := CRBoxBuilder new.
	shapeBuilder with: methods.
	shapeBuilder addNormalizer: self methodHeightNormalizer.
	shapeBuilder addNormalizer: self methodWidthNormalizer.
	shapeBuilder toolTip: #name.
	
	
	^shapeBuilder createNodes
	
]

{ #category : #normalizer }
CRClassBlueprintBuilder >> createNormalizer: anArgBlockOrSymbol from: fromValue to: toValue forAll: aTrueFalseBlock attribute: aBlockSpecifingTheAttribute [
	"A classblueprint shouldn't be normalized"
	self shouldNotImplement 
]

{ #category : #accessing }
CRClassBlueprintBuilder >> createShapeFor: obj [
"
	I create a classBluePrint shape for the given objec, which should be a class.
	Therefore I frist sort the methods into categories and then create a mondrian
	for each categories. These mondrians are then added to the ClassBlueprintCanvas
	as Nodes.
"
	| mondrian methods interface initialization implementor accessor attribute coll shape methodHNorm slotHNorm normW |
	methods := OrderedCollection new.
	methods addAll: obj methods.
	methods addAll: obj class methods.
	
	
	"create the Groups for the categorization"
	initialization := CRGroup new name: 'initialization'.
	interface := CRGroup new name: 'interface'.
	implementor := CRGroup new name: 'implementor'.
	accessor := CRGroup new name: 'accessor'.
	attribute := CRGroup new name: 'attribute'.
	
	attribute addAll: (self createSlotNodes: (obj allSlots)).

	coll := self sortMethodNodes: (self createMethodNodes: methods).
	
	coll add: attribute.
	
	shape := CRClassBlueprintCanvas new.
	shape model: obj.
	
	
	"create the mondrian for each category"
	coll do: [:c | | m canv normH |
		m := CRMondrian new.
		m nodes preBuiltNode 
			addNodeCollection: c.
		
		canv := m createCanvas canvasAsNode addToolTip: c name.
			
		shape addContainer: (canv).
	].
	
	^shape
	

]

{ #category : #accessing }
CRClassBlueprintBuilder >> createSlotNodes: slots [
	| shapeBuilder |
	
	shapeBuilder := CRBoxBuilder new.
	shapeBuilder with: slots.
	"shapeBuilder addNormalizer: self slotHeightNormalizer."
	shapeBuilder addNormalizer: self slotWidthNormalizer.
	shapeBuilder toolTip: #name.
	^shapeBuilder createNodes
	
]

{ #category : #accessing }
CRClassBlueprintBuilder >> initialize [
	super initialize.
	
	"Specify the colors"
	accessEdgeColor := Color cyan.
	invocationEdgeColor := Color blue.
	
	getterColor := Color red.
	setterColor := Color orange.
	interfaceLayerColor := Color white darker.
	attributeColor := Color blue.
	
	constantColor := Color gray.
	delegationColor := Color yellow.
	extendingColor := Color orange.
	overridingColor := Color brown.
	abstractColor := Color cyan.
	
	^self
]

{ #category : #accessing }
CRClassBlueprintBuilder >> methodHeightNormalizer [
	^CRNormalizer new
		key: #linesOfCode;
		attribute: [:node :value | node height: value];
		from: 10;
		to: 75.
]

{ #category : #accessing }
CRClassBlueprintBuilder >> methodWidthNormalizer [
	^CRNormalizer new
		key: [:m | (m callingMethodsIn: modelCollection) size];
		attribute: [:node :value | node width: value];
		from: 10;
		to: 75.
]

{ #category : #accessing }
CRClassBlueprintBuilder >> slotHeightNormalizer [
	^CRNormalizer new
		key: #size;
		attribute: [:node :value | node height: value];
		from: 10; to: 75.
]

{ #category : #accessing }
CRClassBlueprintBuilder >> slotWidthNormalizer [
	^CRNormalizer new
		key: [:slot | slot numberOfAccessesWithin: (slot owningClass allMethods)];
		attribute: [:node :value | node width: value];
		from: 10; to: 75.
]

{ #category : #accessing }
CRClassBlueprintBuilder >> sortAndColorMethodNodes: methodNodes [
"I sort the provided nodes in groups and return the groups as collection"

	| collection initialization interface implementor accessor attribute |
	collection := OrderedCollection new.
	
	"create the Groups for the categorization"
	initialization := CRGroup new name: 'initialization'.
	interface := CRGroup new name: 'interface'.
	implementor := CRGroup new name: 'implementor'.
	accessor := CRGroup new name: 'accessor'.
	attribute := CRGroup new name: 'attribute'.
	

	collection := OrderedCollection new.
	collection add: initialization.
	collection add: interface.
	collection add: implementor.
	collection add: accessor.
	
	"sort the mthods"
	methodNodes do: [ :node | | method |
		method := node model.
		
		(method isAccessor or: method isSetter) ifTrue: [accessor add: node]
		ifFalse: [
			(method isInitialization) ifTrue: [initialization add: node]
				ifFalse: [
					(method isPrivateIn: modelCollection) ifTrue: [implementor add: node]
						ifFalse: [
							interface add: node.
						].
				].
		].
	].
	
	^collection
	
]

{ #category : #accessing }
CRClassBlueprintBuilder >> sortMethodNodes: methodNodes [
"I sort the provided nodes in groups and return the groups as collection"

	| collection initialization interface implementor accessor attribute |
	collection := OrderedCollection new.
	
	"create the Groups for the categorization"
	initialization := CRGroup new name: 'initialization'.
	interface := CRGroup new name: 'interface'.
	implementor := CRGroup new name: 'implementor'.
	accessor := CRGroup new name: 'accessor'.
	attribute := CRGroup new name: 'attribute'.
	

	collection := OrderedCollection new.
	collection add: initialization.
	collection add: interface.
	collection add: implementor.
	collection add: accessor.
	
	"sort the mthods"
	methodNodes do: [ :node | | method |
		method := node model.
		
		(method isInitialization) ifTrue: [
			initialization add: node.
			
		] ifFalse: [
			(method isAccessor) ifTrue: [
				accessor add: node.
				node centerElement background: getterColor.
			] ifFalse: [
				(method isSetter) ifTrue: [
					accessor add: node.
					node centerElement background: setterColor.
				] ifFalse: [
					(method isImplementationLayerMethod) ifTrue: [
						implementor add: node.
						node centerElement background: interfaceLayerColor.
					] ifFalse: [
						interface add: node.
						node centerElement background: interfaceLayerColor.
					].
				].
			].
		].
		
		self colorMethod: node.
		
	].
	
	^collection
	
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
