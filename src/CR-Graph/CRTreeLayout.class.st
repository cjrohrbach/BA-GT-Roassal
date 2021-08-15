"
I extent the {{gtClass:GtGraphTreeLayout}} and I am used to apply an force layout to a {{gtClass:CRMondrian}}

{{gtExample:CRMondrianExamples>>someConnectedPointsTree|codeExpanded=false|previewExpanded=true}}
"
Class {
	#name : 'CRTreeLayout',
	#superclass : 'GtGraphTreeLayout',
	#traits : 'TCRLayout',
	#classTraits : 'TCRLayout classTrait',
	#category : 'CR-Graph-Layout'
}

{ #category : 'initialization' }
CRTreeLayout >> initialize [
	super initialize.
	"self verticalGap: 50.
	self horizontalGap: 50."
	^self
]
