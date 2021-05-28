"
Some examples with CRMondrian
"
Class {
	#name : #CRMondrianExamples,
	#superclass : #Object,
	#category : #'CR-Graph-Examples'
}

{ #category : #accessing }
CRMondrianExamples >> classBlueprint [
	<gtExample>
	| coll view |
	
	coll := OrderedCollection new.
	coll add: CRMondrian.
	coll add: CRActionBuilder.
	coll add: CRNode.

	view := CRMondrian new.
	view nodes classBlueprint with: (coll).
	^view
]

{ #category : #accessing }
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

{ #category : #accessing }
CRMondrianExamples >> edgesToHalf [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
		point
		with: (1 to: 10).
	(m edge connectTo: [:x | x/2]) width: 500.
	
	
	^m
]

{ #category : #accessing }
CRMondrianExamples >> edgesToHalfWithArrow [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
		label
		with: (1 to: 10).
	m edge
		arrow;
		connectFromAll: [:x | x//2].
	m layout tree.
	^m
]

{ #category : #accessing }
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

{ #category : #accessing }
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

{ #category : #accessing }
CRMondrianExamples >> mondrianAsNodeWithEdges [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes 
		mondrianNodes
			toolTip: #value;
			stencil: 
			[ :p | | q |
				q := CRMondrian new .
				q nodes 
					box
					with: (1 to: 9).
				q edge connectFromAll: [:x | x//2].
				q layout tree.
				q
			];
			with: ( 1 to: 9 ).
	m edge connectFromAll: [:x | x//2].
	m layout tree.
	^m
]

{ #category : #accessing }
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

{ #category : #accessing }
CRMondrianExamples >> normalizeColor [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
		box
		normalizeColor: #linesOfCode;
		with: Collection withAllSubclasses.
	^ m 
]

{ #category : #accessing }
CRMondrianExamples >> normalizerAndForceLayout [
	<gtExample>
	| m |

	m := CRMondrian new.
	m nodes
		box
		normalizeHeight: #numberOfMethods;
		normalizeWidth: [:x | x slots size];
		normalizeColor: #linesOfCode;
		with: Collection withAllSubclasses.
	m edge connectToAll: #dependentClasses.
	m layout force.

	^m
]

{ #category : #accessing }
CRMondrianExamples >> primeSieveAction [
	<gtExample>
	| m |
	
	m := CRMondrian new.
	m nodes circle borderWidth: 0.4; with: (1 to: 100).
	m action primeSieve.
	^m
]

{ #category : #accessing }
CRMondrianExamples >> randomBackgroundAction [
	<gtExample>
	| m |
	
	m := CRMondrian new.
	m nodes box with: (1 to: 9).
	m action randomBackground.
	^m
]

{ #category : #accessing }
CRMondrianExamples >> smallAndBigCircles [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes 
		circle size: [:x | x];
		with: (1 to: 100).
	^c
]

{ #category : #accessing }
CRMondrianExamples >> someCircles [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes 
		circle size: 20;
		with: (1 to: 100).
	^c
]

{ #category : #accessing }
CRMondrianExamples >> someConnectedPointsTree [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes 
		point
		with: (1 to: 100).
	m edge
		width: 1; 
		color: Color gray;
		connectFrom: [:nb | nb // 2].
	m layout tree.
	^m
]

{ #category : #accessing }
CRMondrianExamples >> someNumbers [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes box with: (1 to: 9).
	^c
]

{ #category : #accessing }
CRMondrianExamples >> systemComplexity [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
		box
		normalizeHeight: #numberOfMethods from: 5 to: 25;
		normalizeWidth: [:x | x slots size] from: 5 to: 25;
		normalizeColor: #linesOfCode;
		with: (RPackageOrganizer default packageNamed: 'Kernel') classes.
	m edge connectFrom: #superclass.
	m layout tree.
	^m
]
