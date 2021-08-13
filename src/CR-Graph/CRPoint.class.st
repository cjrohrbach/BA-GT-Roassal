"
I am just a simple box element.
I extend {{gtClass:BlElement}} and apply a {{gtClass:BlCircle}} geometry as default.

{{gtExample:CRPoint>>#example|noCode=true}}
"
Class {
	#name : #CRPoint,
	#superclass : #BlElement,
	#category : #'CR-Graph-NodeShape'
}

{ #category : #accessing }
CRPoint >> example [
"I am an example for my class comment"
	<gtExample>
	^CRPoint new
]

{ #category : #accessing }
CRPoint >> initialize [.
	super initialize.
	self geometry: BlCircle new.
	self size: 25 asPoint.
	self background: Color black.
	^self
]
