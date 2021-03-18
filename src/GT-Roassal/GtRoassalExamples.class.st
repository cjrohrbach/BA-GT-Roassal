Class {
	#name : #GtRoassalExamples,
	#superclass : #Object,
	#category : #'GT-Roassal-Examples'
}

{ #category : #accessing }
GtRoassalExamples >> simpleNodeGraph [
	<gtExample>
	| view |
	view := GtRoassal new.
	view nodes: (1 to: 9).
	view shape: #point.
	view build.
	^ view
]
