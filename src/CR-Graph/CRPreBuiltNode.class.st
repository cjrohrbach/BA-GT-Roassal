"
I can be used to add prebuilt nodes to a Mondrian instance

{{gtExample:CRMondrianExamples>>#preBuiltNode|previewExpanded=true|codeExpanded=true}}
"
Class {
	#name : #CRPreBuiltNode,
	#superclass : #CRShapeBuilder,
	#instVars : [
		'nodes'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRPreBuiltNode >> addNode: aNode [
"add a prebuilt node"
	nodes add: aNode.
]

{ #category : #accessing }
CRPreBuiltNode >> createNodes [
"nodes don't need to be created since they are allready provided"
	^nodes
]

{ #category : #accessing }
CRPreBuiltNode >> initialize [
	super initialize.
	nodes := CRGroup new.
	^self
]