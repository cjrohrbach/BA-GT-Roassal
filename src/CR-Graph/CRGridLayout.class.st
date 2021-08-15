"
I am a grid layout. 

Before applying myself on a canvas I calculate the columns necessary to be as square as possible.

{{gtExample:CRGridLayout>>example|codeExpanded=false|previewExpanded=true}}
"
Class {
	#name : 'CRGridLayout',
	#superclass : 'BlGridLayout',
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#category : 'CR-Graph-Layout'
}

{ #category : 'accessing' }
CRGridLayout >> example [
"I am an example used in my class comments"
	<gtExample>
	| m |
	m := CRMondrian new.
	m nodes with: (1 to: 9).
	m layout grid.
	^m
]

{ #category : 'initialization' }
CRGridLayout >> initialize [
	super initialize .
	self cellSpacing: 10.
	self horizontal.
	^ self 
]

{ #category : 'accessing' }
CRGridLayout >> on: aCanvas [
"I apply the layout to the given Canvas. But first I calculate the neccessary columns to have a nice layout and create a BlOnceLayout from myself to allow draggable nodes"
	self columnCount: ((aCanvas nodeCount sqrt) floor) .
	aCanvas layout: (BlOnceLayout new layout: self).
]
