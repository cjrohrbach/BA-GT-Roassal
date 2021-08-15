Class {
	#name : 'CRClusterLayout',
	#superclass : 'GtGraphClusterLayout',
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#category : 'CR-Graph-Layout'
}

{ #category : 'accessing' }
CRClusterLayout >> initialize [
	super initialize.
	^self
]

{ #category : 'accessing' }
CRClusterLayout >> on: aCanvas [
"I apply the layout to the given Canvas. But first I create a BlOnceLayout from myself to allow draggable nodes"
	aCanvas layout: (BlOnceLayout new layout: self)
]
