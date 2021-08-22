Class {
	#name : 'RandomTests',
	#superclass : 'Object',
	#category : 'BA-Testing-BA-Testing'
}

{ #category : 'accessing' }
RandomTests >> a [
	<gtExample>
	| element el2 |
	element := BlElement new.
	element background: Color red.
	element size: 75@75.
	element addEventHandler: BlPullHandler new.
	element addEventHandlerOn: BlClickEvent do: [self b: 4].

	element relocate: 100@0.
	element graph beNode.
	element graph model: 4.
	
	
	el2 := BlElement new
		size: 1000@1000.
	el2 addChild: element.
	
	el2 graph beChildrenContainer.
	
	^ el2
]

{ #category : 'accessing' }
RandomTests >> b: aNumber [
 ^GtPageElement new
]
