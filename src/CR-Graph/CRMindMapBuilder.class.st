Class {
	#name : #CRMindMapBuilder,
	#superclass : #CRShapeBuilder,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRMindMapBuilder >> createShapeFor: obj [
	| c a b circle top center group |
	
	circle := CRMondrian new.
	circle nodes box toolTip: #model; with: (obj getChildren).
	circle edges connectTo: #parent.
	circle layout circle.
	
	top := CRMondrian new.
	top nodes preBuiltNode addNode: ((circle createCanvas canvasAsNode) model: (MindMapNode new); border: (BlBorder empty)).
	top nodes preBuiltNode addNode: ((
		CRBox new
			model: obj;
			toolTipContent: (obj model);
			constraintsDo: [:con |
				con frame horizontal alignCenter.
				con frame vertical alignCenter.
			]
			)). 
	top edges connectFrom: #parent.
	top layout custom: BlFrameLayout new.
		
	^top createCanvas canvasForView
]
