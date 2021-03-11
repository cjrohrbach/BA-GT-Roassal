Class {
	#name : #'GT_BA_Examples',
	#superclass : #Object,
	#category : #'BA-Testing'
}

{ #category : #accessing }
GT_BA_Examples >> edgesToHalf [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes with: (1 to: 10).
	view edges connectFrom: [ :x | x / 2 ].
	view layout grid.
	^ view
]

{ #category : #accessing }
GT_BA_Examples >> graphWithGtMondrianMethods [
	<gtExample>
	| view c package |
	c := OrderedCollection new.
	package := (RPackageOrganizer default packageNamed: 'GToolkit-Mondrian') definedClasses.
	
	package do: [ :each | 
		(c add: each). 
		(each methods) do: [:x | c add:x]].

	view := GtMondrian new.
	view nodes 
		shape: [ :x | BlElement new
			geometry: (BlRectangle cornerRadius: 0);
			size: 10 @ 10;
			background:(x isClass
				ifTrue: [Color green]
				ifFalse: [Color red])];
		with: (c).
		
	view edges connectFrom: [:x | (x isClass
		ifTrue: [x methods]
		ifFalse: [x classBinding])].
	view layout grid.
	^ view
]

{ #category : #accessing }
GT_BA_Examples >> multipleNodes [
	<gtExample>
	| m |
	m := GtMondrian new.
	m nodes with: (1 to: 9).
	m layout grid.
	^ m
]

{ #category : #accessing }
GT_BA_Examples >> nodesWithEllipses [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			BlElement new 
				border: (BlBorder paint: Color black);
				geometry: BlEllipseGeometry new; 
				size: 10 @ 10 ];
		with: (1 to: 9).
	view layout grid.
	^ view
]

{ #category : #accessing }
GT_BA_Examples >> nodesWithGtClasses [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes with: ((RPackageOrganizer default packageNamed: 'GToolkit-Mondrian') definedClasses).
	view layout grid.
	^ view
]

{ #category : #accessing }
GT_BA_Examples >> nodesWithGtMethods [
	<gtExample>
	| view c |
	c := OrderedCollection new.
(((RPackageOrganizer default packageNamed: 'GToolkit-Mondrian') definedClasses ) do: [ :each | (each methods) do: [:x | c add:x]]).
	view := GtMondrian new.
	view nodes with: (c) .
	view layout grid.
	^ view
]

{ #category : #accessing }
GT_BA_Examples >> nodesWithGtMondrianClasses [
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes with: ((RPackageOrganizer default packageNamed: 'GToolkit-Mondrian') definedClasses).
	view layout grid.
	^ view
]

{ #category : #accessing }
GT_BA_Examples >> nodesWithGtMondrianMethods [
	<gtExample>
	| view c |
	c := OrderedCollection new.
	
	(((RPackageOrganizer default packageNamed: 'GToolkit-Mondrian') definedClasses ) do: [ :each | 
		(c add: each). 
		(each methods) do: [:x | c add:x]]).

	view := GtMondrian new.
	view nodes 
		shape: [ :x | BlElement new
			geometry: (BlRectangle cornerRadius: 10);
			size: 10 @ 10;
			background:(x isClass
				ifTrue: [Color green]
				ifFalse: [Color red])];
		with: (c).
	view layout grid.
	^ view
]

{ #category : #accessing }
GT_BA_Examples >> nodesWithTooltip [
	<gtExample>
	| m  |
	
	m := GtMondrian new.
	m nodes 
		shape: [ :x | BlElement new
			geometry: (BlRectangle cornerRadius: 1);
			size: 10 @ 10;
			background: Color gray;
			look: (BrGlamorousWithLabelTooltipLook content: (BrLabel new
				look: BrGlamorousLabelLook new glamorousRegularFontAndSize;
				alignCenter;
				text: x asRopedText));
				yourself];
		with: (1 to: 9).
	m layout grid.
	^ m
]
