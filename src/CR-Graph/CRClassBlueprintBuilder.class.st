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
	| centerElement colorCat |
	centerElement := aNode centerElement.
	colorCat := aNode model classBlueprintColorCategory.
	
	(colorCat = #abstract) ifTrue: [centerElement background: abstractColor].
	(colorCat = #extending) ifTrue: [centerElement background: extendingColor].
	(colorCat = #overriding) ifTrue: [centerElement background: overridingColor].
	(colorCat = #delegating) ifTrue: [centerElement background: delegationColor].
	(colorCat = #constant) ifTrue: [centerElement background: constantColor].
	

	
]

{ #category : #accessing }
CRClassBlueprintBuilder >> colorMethod: method container: con [
	| colorCat |
	colorCat := method classBlueprintColorCategory.
	
	(colorCat = #abstract) ifTrue: [^abstractColor].
	(colorCat = #extending) ifTrue: [^extendingColor].
	(colorCat = #overriding) ifTrue: [^overridingColor].
	(colorCat = #delegating) ifTrue: [^delegationColor].
	(colorCat = #constant) ifTrue: [^constantColor].
	
	con name = 'implementor' ifTrue: [^interfaceLayerColor].
	con name = 'interface' ifTrue: [^interfaceLayerColor].
	con name = 'accessor' ifTrue: [(method isSetter) ifTrue: [^setterColor] ifFalse: [^getterColor]].
	
	^Color black
	
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
	|  sortedMethods methods slots cp scope |
	methods := OrderedCollection new.
	methods addAll: obj methods.
	
	sortedMethods := self sortMethods: methods.
	slots := CRGroup new name: 'slots'.
	slots addAll: (obj slots).
	
	
	scope := (modelCollection collect: [:class | class package]) copyWithoutDuplicates.

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
				background: [:m | self colorMethod: m container: con];
				toolTip: #name; 
				normalizeHeight: #linesOfCode;
				normalizeWidth: [:m | ( m sendersInPackageCollection: scope ) size];
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
	cp edges 
		arrow;
		color: Color blue;
		forAll: [:x | x class = CompiledMethod]; 
		connectFromAll: [:m | (m sendersInPackageCollection: scope) collect: [:s | s method]].
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
