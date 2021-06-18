Class {
	#name : #CRGraphvizLayout,
	#superclass : #GraphvizLayout,
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#category : #'CR-Graph-Layout'
}

{ #category : #accessing }
CRGraphvizLayout >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRGraphvizLayout >> on: aCanvas [
"I apply the layout to the given Canvas. But first I create a BlOnceLayout from myself to allow draggable nodes"
	aCanvas layout: (BlOnceLayout new layout: (BlFitChildrenLayout new addLayout: self)).
	"aCanvas layout: (BlOnceLayout new layout: self)."
]
