"
I am a Trait used for CRLayouts. All CRLayouts should reference me.
"
Trait {
	#name : 'TCRLayout',
	#category : 'CR-Graph-Layout'
}

{ #category : 'accessing' }
TCRLayout >> on: aCanvas [
"I apply the layout to the given Canvas. But first I create a BlOnceLayout from myself to allow draggable nodes"
	aCanvas layout: (BlOnceLayout new layout: self)
]
