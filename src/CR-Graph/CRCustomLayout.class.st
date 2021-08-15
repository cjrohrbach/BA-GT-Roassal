"
I can be used to apply any layout to a {{gtClass:CRMondrian}} instance.

{{gtExample:CRCustomLayout>>#example|codeExpanded=true|previewExpanded=true}}
"
Class {
	#name : 'CRCustomLayout',
	#superclass : 'Object',
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#instVars : [
		'layout'
	],
	#category : 'CR-Graph-Layout'
}

{ #category : 'accessing' }
CRCustomLayout >> example [
"I am an example used in my class comment"
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes with: (1 to: 10).
	m layout custom: (BlGridLayout new columnCount: 2).
	^m 
]

{ #category : 'accessing' }
CRCustomLayout >> layout: aLayout [
"set the layout"
	layout := aLayout
]

{ #category : 'accessing' }
CRCustomLayout >> on: aCanvas [
"I apply the layout to the given Canvas. But first I create a BlOnceLayout from myself to allow draggable nodes"
	aCanvas layout: (BlOnceLayout new layout: layout)
]
