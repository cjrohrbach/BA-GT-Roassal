"
Some examples with CRMondrian
"
Class {
	#name : #CRMondrianExamples,
	#superclass : #Object,
	#category : #'CR-Graph-Examples'
}

{ #category : #accessing }
CRMondrianExamples >> edgesToHalf [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
		point;
		with: (1 to: 10).
	(m edge connectTo: [:x | x/2]) width: 500.
	^m
]

{ #category : #accessing }
CRMondrianExamples >> edgesWithColorAndWidthSpecified [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes with: (1 to: 10).
	m edge 
		width: 2;
		color: Color blue; 
		connectTo: [:x | x//2].
	m layout tree.
	
	^ m
]

{ #category : #accessing }
CRMondrianExamples >> evenAndUnevenNumbersSeparatedByColor [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes 
		box;
		color: [:x | x%2=0 ifTrue: [Color green ] ifFalse: [Color red]];
		with: (1 to: 10).
	^m
]

{ #category : #accessing }
CRMondrianExamples >> nodesWithDifferentScopes [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes
		point;
		color: (Color gray);
		with: (1 to: 10). 

	c nodes
		label;
		color: (Color white);
		with: (1 to: 10). 
	^c
]

{ #category : #accessing }
CRMondrianExamples >> normalizeColor [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
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
		normalizeHeight: #numberOfMethods;
		normalizeWidth: [:x | x slots size];
		normalizeColor: #linesOfCode;
		with: Collection withAllSubclasses.
	m edges: #dependentClasses.
	m layout force.

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
		point; 
		with: (1 to: 100).
	m edge
		width: 1; 
		color: Color gray;
		connectTo: [:nb | nb // 2].
	m layout tree.
	^m
]

{ #category : #accessing }
CRMondrianExamples >> someNumbers [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes with: (1 to: 9).
	^c
]

{ #category : #accessing }
CRMondrianExamples >> systemComplexity [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes
		normalizeHeight: #numberOfMethods from: 5 to: 25;
		normalizeWidth: [:x | x slots size] from: 5 to: 25;
		normalizeColor: #linesOfCode;
		with: (RPackageOrganizer default packageNamed: 'Kernel') classes.
	m edges: #superclass.
	m layout tree.
	^m
]
