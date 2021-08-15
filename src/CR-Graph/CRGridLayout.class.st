"
I extent the ${class:BlGridLayout}$ and I am used to apply an force layout to a CRMondrian.
"
Class {
	#name : 'CRGridLayout',
	#superclass : 'BlGridLayout',
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#category : 'CR-Graph-Layout'
}

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
