"
I extent the{{ gtClass:GtGraphForceBasedLayout}} and I am used to apply an force layout to a {{gtClass:CRMondrian}}


{{gtExample:CRForceLayout>>#example|codeExpanded=false|previewExpanded=true}}
"
Class {
	#name : 'CRForceLayout',
	#superclass : 'GtGraphForceBasedLayout',
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#category : 'CR-Graph-Layout'
}

{ #category : 'accessing' }
CRForceLayout >> example [
"I am an example used in my class comment"
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes with: ( 1 to: 20).
	m edges connectFrom: [:x | x // 2].
	m layout force.
	^m
]

{ #category : 'initialization' }
CRForceLayout >> initialize [
	super initialize.
	self length: 150.
	^self
]
