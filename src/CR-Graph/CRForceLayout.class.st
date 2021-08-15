"
I extent the ${class:GtGraphForceBasedLayout}$ and I am used to apply an force layout to a CRMondrian
"
Class {
	#name : 'CRForceLayout',
	#superclass : 'GtGraphForceBasedLayout',
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#category : 'CR-Graph-Layout'
}

{ #category : 'initialization' }
CRForceLayout >> initialize [
	super initialize.
	self length: 100.
	^self
]
