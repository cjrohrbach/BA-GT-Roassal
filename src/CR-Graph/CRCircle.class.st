"
I am the default shape for {{gtClass:CRMondrian}} nodes with circle shape

{{gtExample:CRCircle>>#example|codeExpanded=false|previewExpanded=true}}
"
Class {
	#name : 'CRCircle',
	#superclass : 'BlElement',
	#category : 'CR-Graph-NodeShape'
}

{ #category : 'accessing' }
CRCircle >> example [
"I am an example for my class comment"
	<gtExample>
	^CRCircle new
]

{ #category : 'accessing' }
CRCircle >> initialize [
	super initialize.
	self geometry: BlCircle new.
	self size: 25 asPoint.
	self border: (BlBorder paint: Color black width: 2).
	^self
]
