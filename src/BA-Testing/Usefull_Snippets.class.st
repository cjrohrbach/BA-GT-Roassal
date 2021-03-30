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
Usefull_Snippets >> getAllPackages [
	<gtExample>
	^ RPackageOrganizer default
]
