"
Some examples with CRMondrian
"
Class {
	#name : #CRMondrianExamples,
	#superclass : #Object,
	#category : #'CR-Graph-Examples'
}

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
CRMondrianExamples >> someNumbers [
	<gtExample>
	| c |
	c := CRMondrian new.
	c nodes: (1 to: 9).
	^c
]
