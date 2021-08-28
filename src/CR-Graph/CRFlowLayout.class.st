"
I am a flow layout 

{{gtExample:CRFlowLayout>>#example|codeExpanded=false|previewExpanded=true}}
"
Class {
	#name : 'CRFlowLayout',
	#superclass : 'BlFlowLayout',
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#category : 'CR-Graph-Layout'
}

{ #category : 'accessing' }
CRFlowLayout >> example [
"I am an example used for my class comment"
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes with: (1 to: 10).
	m layout flow. 
	^m
]

{ #category : 'accessing' }
CRFlowLayout >> initialize [
	super initialize.
	^self
]
