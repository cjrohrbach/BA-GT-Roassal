Class {
	#name : #'Usefull_Snippets',
	#superclass : #Object,
	#category : #'BA-Testing-BA-Testing'
}

{ #category : #accessing }
Usefull_Snippets >> blElementDraggableWithModelOnClick [
	<gtExample>
	|element|
	element := BlElement new	
		background: Color red;
		size: 75@75;
		addEventHandler: BlPullHandler new;
		addEventHandlerOn: BlClickEvent do: [:e | e target phlow spawnObject: 42 ].

	^element
]

{ #category : #accessing }
Usefull_Snippets >> blElementsWithEdge [
	<gtExample>
	| canvas l e z |
	canvas := BlElement new
	size: 1000@1000.
	
	z := BlElement new
		background: Color blue;
			size: 75@75;
			addEventHandler: BlPullHandler new.
	
	e := BlElement new				background: Color red;			size: 75@75;
					addEventHandler: BlPullHandler new;
					relocate: 200@200.
	
	l := BlLineElement new
		border: (BlBorder paint: (Color black alpha: 1) width: 2);
		zIndex: -1;
		fromAnchor: (BlNearestPositionBoundsAnchor referenceElement: z relatedTo: e);
		toAnchor: (BlNearestPositionBoundsAnchor referenceElement: e relatedTo: z).
	l constraints ignoreByLayout.

	
	canvas addChild: z.
	canvas addChild: e.
	canvas addChild: l.


	^canvas
]

{ #category : #accessing }
Usefull_Snippets >> getAllPackages [
	<gtExample>
	^ RPackageOrganizer default
]
