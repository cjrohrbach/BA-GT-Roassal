"
Some examples with CRMondrian
"
Class {
	#name : 'CRMondrianExamples',
	#superclass : 'Object',
	#category : 'CR-Graph-Examples'
}

{ #category : 'accessing' }
CRMondrianExamples >> classBlueprint [
	<gtExample>
	| classes scope view methodHNorm |
	
	"classes := (RPackageOrganizer default packageNamed: 'CR-Graph') classes."
	
	classes := OrderedCollection new.
	classes addAll: CRShapeBuilder subclasses.
	classes add: CRShapeBuilder. 
	
	scope := (classes collect: [:class | class package]) copyWithoutDuplicates.

	view := CRMondrian new.
	view nodes 
		classBlueprint 
		anchorPosition: (BlNearestPositionBoundsAnchor);
		noHighlights; 
		with: (classes).
	view edges forAll: [:x | x isClass]; connectFrom: #superclass.
	view edges 
		arrow;
		color: Color blue;
		forAll: [:x | x class = CompiledMethod]; 
		connectFromAll: [:m | (m sendersInPackageCollection: scope) collect: [:s | s method]].

	view layout tree.

	^view
]

{ #category : 'accessing' }
CRMondrianExamples >> customAction [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes box with: (1 to: 9).
	m action 
		custom
		on: BlClickEvent do: [:x | x target background: Color random].
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> customHighlights [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes 
		box 
		hoverColor: (Color cyan); 
		clickColor: (Color pink);
		connectedColor: (Color yellow);
		with: (1 to: 10).
	m edges 
		arrow;
		highlightColor: (Color blue) ; 
		highlightWidth: 3;
		connectFrom: [:x | x//2].
	m layout tree.
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> customShape [
<gtExample>
| q |
	q := CRMondrian new.
	q nodes 
		custom 
			stencil:  [ :x |
				BlElement new
				size: 20@50;
				background: Color gray.
			]; 
			with: (1 to: 9).
	^q 
]

{ #category : 'accessing' }
CRMondrianExamples >> edgesToHalf [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
		point
		with: (1 to: 10).
	m edges connectTo: [:x | x/2].
	
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> edgesToHalfWithArrow [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
		label
		with: (1 to: 10).
	m edges
		arrow;
		connectFromAll: [:x | x//2].
	m layout tree.
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> evenAndUnevenNumbersSeparatedByColor [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes 
		box
		background: [:x | x%2=0 ifTrue: [Color green ] ifFalse: [Color red]];
		with: (1 to: 10).
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> methodsAndClassesWithoutCommentHighlighted [
	<gtExample>
	| q |
	q := CRMondrian new.
	q nodes 
		mondrianNodes
		toolTip: #name;
		stencil: 
		[ :p | | m |
			m := CRMondrian new .
			m nodes 
				box
				toolTip: #name; 
				with: (p methods ).
			m];
		with: ( (RPackageOrganizer default packageNamed: 'CR-Graph') classes ).
		

	^q
]

{ #category : 'accessing' }
CRMondrianExamples >> methodsWithoutCommentHighlighted [
	<gtExample>
	| q package |
	package := (RPackageOrganizer default packageNamed: 'CR-Graph') classes.
	package remove: CompiledMethod.
	package remove: BlElement.
	package remove: InstanceVariableSlot.
	package remove: CRMondrianExamples.
	
	q := CRMondrian new.
	q nodes 
		mondrianNodes
		toolTip: #name;
		stencil: 
		[ :p | | m |
			m := CRMondrian new .
			m nodes 
				box
				toolTip: #name; 
				background: [:x | (x comment = nil and: ((x name includesSubstring: 'initialize' ) not)) ifTrue: [Color red] ifFalse: [Color gray] ];
				with: (p methods ).
			m];
		with: package.
		

	^q
]

{ #category : 'accessing' }
CRMondrianExamples >> mondrianAsNode [
	<gtExample>
	| q |
	q := CRMondrian new.
	q nodes 
		mondrianNodes
		toolTip: #name;
		stencil: 
		[ :p | | m |
			m := CRMondrian new .
			m nodes 
				box
				toolTip: #name; 
				with: (p methods ).
			m];
		with: ( (RPackageOrganizer default packageNamed: 'CR-Graph') classes ).
		

	^q
]

{ #category : 'accessing' }
CRMondrianExamples >> mondrianAsNodeWithEdges [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes 
		mondrianNodes
			background: Color transparent;
			toolTip: #value;
			stencil: 
			[ :p | | q |
				q := CRMondrian new .
				q nodes 
					box
					with: (1 to: 9).
				q edges connectFromAll: [:x | x//2].
				q layout tree.
				q
			];
			with: ( 1 to: 9 ).
	m edges connectFromAll: [:x | x//2].
	m layout tree.
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> mondrianWithoutHighlights [
"an example with no highlights for the nodes when clicking, hovering, etc"
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes box with: (1 to: 10).
	m edges connectFrom: [:x | x//2].
	m layout tree.
	m noHighlights.
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> nodesWithDifferentScopes [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes
		point
		background: (Color gray);
		with: (1 to: 10). 

	c nodes
		label
		background: (Color white);
		with: (1 to: 10). 
	
	^c
]

{ #category : 'accessing' }
CRMondrianExamples >> normalizeColor [
"Normalize the background. The darker the node, the more lines of code it has"
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
		box
		normalizeBackground: #linesOfCode;
		with: Collection withAllSubclasses.
	^ m 
]

{ #category : 'accessing' }
CRMondrianExamples >> normalizerAndForceLayout [
	<gtExample>
	| m |

	m := CRMondrian new.
	m nodes
		box
		normalizeHeight: #numberOfMethods;
		normalizeWidth: [:x | x slots size];
		normalizeBackground: #linesOfCode;
		with: Collection withAllSubclasses.
	m edges connectToAll: #dependentClasses.
	m layout force.

	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> oneLineClassBlueprint [
	<gtExample>
	| classes |
	classes := OrderedCollection new.
	classes addAll: (CRShapeBuilder subclasses).
	classes add: CRShapeBuilder. 
	^CRMondrian new classBlueprintFor: classes
]

{ #category : 'accessing' }
CRMondrianExamples >> preBuiltNode [
	<gtExample>
	| node mondrian |
	
	node := CRNode new
		shape: (CRBox new
			size: 50@100;
			background: Color blue;
			border: (BlBorder paint: (Color gray) width: 5));
		model: 'test Node'.
	
	mondrian := CRMondrian new.
	mondrian nodes preBuiltNode addNode: (node).
	^mondrian
]

{ #category : 'accessing' }
CRMondrianExamples >> primeSieveAction [
	<gtExample>
	| m |
	
	m := CRMondrian new.
	m nodes circle borderWidth: 0.4; with: (1 to: 100).
	m action primeSieve.
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> randomBackgroundAction [
	<gtExample>
	| m |
	
	m := CRMondrian new.
	m nodes box with: (1 to: 9).
	m action randomBackground.
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> sigmoidEdges [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes with: (1 to: 20).
	m edges sigmoid; connectFrom: [:x | x//2].
	m layout tree.
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> smallAndBigCircles [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes 
		circle size: [:x | x];
		with: (1 to: 100).
	^c
]

{ #category : 'accessing' }
CRMondrianExamples >> someCircles [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes 
		circle size: 20;
		with: (1 to: 100).
	^c
]

{ #category : 'accessing' }
CRMondrianExamples >> someConnectedPointsTree [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes 
		point
		with: (1 to: 100).
	m edges
		width: 1; 
		color: Color gray;
		connectFrom: [:nb | nb // 2].
	m layout tree.
	^m
]

{ #category : 'accessing' }
CRMondrianExamples >> someNumbers [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes with: (1 to: 9).
	^c
]

{ #category : 'accessing' }
CRMondrianExamples >> systemComplexity [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
		box
		normalizeHeight: #numberOfMethods from: 5 to: 25;
		normalizeWidth: [:x | x slots size] from: 5 to: 25;
		normalizeBackground: #linesOfCode;
		with: (RPackageOrganizer default packageNamed: 'Kernel') classes.
	m edges connectFrom: #superclass.
	m layout tree.
	^m
]
