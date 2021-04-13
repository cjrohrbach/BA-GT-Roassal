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
	m shape point.
	m nodes: (1 to: 10).
	(m edge connectTo: [:x | x/2]) width: 500.
	^m
]

{ #category : #accessing }
CRMondrianExamples >> edgesWithColorAndWidthSpecified [
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes: (1 to: 10).
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
	m shape box 
		color: [:x | x%2=0 ifTrue: [Color green ] ifFalse: [Color red]].
	m nodes: (1 to:10).
	^m
]

{ #category : #accessing }
CRMondrianExamples >> normalizeColor [
	<gtExample>
	| m |
	m := CRMondrian new.
	m normalizeColor: #linesOfCode.
	m nodes: Collection withAllSubclasses.
	^ m 
]

{ #category : #accessing }
CRMondrianExamples >> normalizerAndForceLayout [
	<gtExample>
	| m |

	m := CRMondrian new.
	(m normalizeHeight: #numberOfMethods) from: 5  to: 50.
	(m normalizeWidth: [:x | x slots size]) from: 5  to: 50.
	m nodes: Collection withAllSubclasses.
	m edges: #dependentClasses.
	m layout force.

	^m
]

{ #category : #accessing }
CRMondrianExamples >> smallAndBigCircles [
	<gtExample>
	| c |
	c := CRMondrian new.
	c shape circle size: [ :aNumber | aNumber ].
	c nodes: (1 to: 100).
	^c
]

{ #category : #accessing }
CRMondrianExamples >> someCircles [
	<gtExample>
	| c |
	c := CRMondrian new.
	c shape circle size: 20.
	c nodes: (1 to: 100).
	^c
]

{ #category : #accessing }
CRMondrianExamples >> someConnectedPointsTree [
	<gtExample>
	| m |
	m := CRMondrian new.
	m shape point.
	m nodes: (1 to: 100).
	m edges: [:nb | nb // 2].
	m layout tree.
	^m
]

{ #category : #accessing }
CRMondrianExamples >> someNumbers [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes: (1 to: 9).
	^c
]

{ #category : #accessing }
CRMondrianExamples >> systemComplexity [
	<gtExample>
	| m |
	m := CRMondrian new.
	(m normalizeHeight: #numberOfMethods) from: 5 to: 25.
	(m normalizeWidth: [:x | x slots size]) from: 5 to: 25.
	m normalizeColor: #linesOfCode.
	m nodes: (RPackageOrganizer default packageNamed: 'Kernel') classes.
	m edges: #superclass.
	m layout tree.
	^m
]
