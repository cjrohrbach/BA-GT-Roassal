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
	|  sortedMethods methods slots cp |
	methods := OrderedCollection new.
	methods addAll: obj methods.
	
	sortedMethods := self sortMethods: methods.
	slots := CRGroup new name: 'slots'.
	slots addAll: (obj slots).
	
	


	cp := CRMondrian new.
	cp nodes 
		label 
			constraintsBlock: ([:constraint | 
				constraint grid horizontal span: 5.
				constraint grid horizontal alignCenter.]); 
			with: {obj}.
	cp nodes
		mondrianNodes
			noHighlights;
			toolTip: #name;
			stencil: [ :con | | mon |
				mon := CRMondrian new.
				mon nodes 
				box 
				background: [:m | self methodColor: m container: con];
				toolTip: #name; 
				normalizeHeight: #linesOfCode;
				"normalizeWidth: [:m | ( m senders ) size];"
				with: con.
				mon
			]; with: sortedMethods.
	cp nodes
		mondrianNodes
			noHighlights;
			toolTip: #name;
			stencil: [:con | | mon |
				mon := CRMondrian new.
				mon nodes 
					box 
					background: attributeColor;
					toolTip: #name; 
					normalizeSize: [:x | (x usingMethods) size];
					with: con.
				mon
			]; with: {slots}.
	cp layout custom: (BlGridLayout new columnCount: 5; cellSpacing: 20).


	^cp createCanvas canvasAsNode
	

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
CRClassBlueprintBuilder >> methodColor: method container: con [ 
	| cat |
	cat := method classBlueprintColorCategory.
	cat = #abstract ifTrue: [^abstractColor].
	cat = #extending ifTrue: [^extendingColor].
	cat = #overriding ifTrue: [^overridingColor].
	
	con name = 'implementation' ifTrue: [^interfaceLayerColor].
	con name = 'interface' ifTrue: [^interfaceLayerColor].
	con name = 'accessor' ifTrue: [(method isSetter) ifTrue: [^setterColor] ifFalse: [^getterColor]].
	
	^Color pink
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
CRClassBlueprintBuilder >> sortMethods: someMethods [
	| methodContainer initialization interface implementor accessor attribute |
	
	"create the Groups for the categorization"
	initialization := CRGroup new name: 'initialization'.
	interface := CRGroup new name: 'interface'.
	implementor := CRGroup new name: 'implementor'.
	accessor := CRGroup new name: 'accessor'.
	

	methodContainer := {initialization. interface. implementor. accessor.}.
	
	"sort the mthods"
	someMethods do: [ :method | 	
		(method isInitialization) ifTrue: [
			initialization add: method.		
		] ifFalse: [
			(method isAccessor or: method isSetter) ifTrue: [
				accessor add: method.
			] ifFalse: [
				(method isImplementationLayerMethod) ifTrue: [
					implementor add: method.
				] ifFalse: [
						interface add: method.
				].
			].
		].
	].
	
	^methodContainer
]
