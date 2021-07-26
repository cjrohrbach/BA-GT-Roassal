"
I represent the node elements.

"
Class {
	#name : #CRNode,
	#superclass : #BlElement,
	#traits : 'TCRNode',
	#classTraits : 'TCRNode classTrait',
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRNode >> initialize [
	super initialize.
	self clipChildren: false.
	isDebugViewActive := false.
	isHighlighted := false.
	
	self addToolTip.
	self makeDraggable.
	self highlightOnClick.
	self openNodeOnShiftClick.
	self graph beNode.
	self zIndex: 10.
	
	
	^self
]

{ #category : #accessing }
CRNode >> initializeForCanvas [
	super initialize.
	self clipChildren: false.
	isDebugViewActive := false.
	isHighlighted := false.
	^self
]
