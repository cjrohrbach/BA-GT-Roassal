Class {
	#name : 'CRCircleLayout',
	#superclass : 'GtGraphCircleLayout',
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#category : 'CR-Graph-Layout'
}

{ #category : 'accessing' }
CRCircleLayout >> example [
"I am an example used in my class comment"
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes with: (1 to: 10).
	m layout circle.
	^m 
]

{ #category : 'accessing' }
CRCircleLayout >> initialize [
	super initialize.
	^self
]
