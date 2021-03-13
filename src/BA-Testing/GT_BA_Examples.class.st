"
I am a collection of usefull examples.
"
Class {
	#name : #'GT_BA_Examples',
	#superclass : #Object,
	#category : #'BA-Testing'
}

{ #category : #accessing }
GT_BA_Examples >> Testing [ 
	<gtExample>
	| view c p |
	c := OrderedCollection new.
	p := (RPackageOrganizer default packageNamed: 'GToolkit-Mondrian') definedClasses.
	
	
	
	view := GtMondrian new.
	view nodes with: (p).
	
	
	view layout grid.
	^ view
	
]

{ #category : #accessing }
GT_BA_Examples >> boxWithColorChangeOnHover [
	| box |
	box := BlElement new
		geometry: (BlRectangle cornerRadius: 5);
		background: Color gray;
		size: 50@50;
		clipChildren: false;
		yourself.
		
	box addEventHandlerOn: BlMouseEnterEvent do: [box background: Color green].
	box addEventHandlerOn: BlMouseLeaveEvent do: [box background: Color gray].
		
	^ box
]

{ #category : #accessing }
GT_BA_Examples >> boxWithLabelOnHover: labelContent [
 "create a BlElement with a label poping up when the mouse is over it"
	| box label |
	box := BlElement new
		geometry: (BlRectangle cornerRadius: 5);
		background: Color gray;
		size: 50@50;
		clipChildren: false;
		zIndex: 1;
		yourself.
		
	label := BrLabel new
		look: BrGlamorousLabelLook new;
		background: Color red;
		text: labelContent asRopedText;
		size: 40@40;
		zIndex:100.
		
	box addEventHandlerOn: BlMouseEnterEvent do: [
		"label relocate: (pos x)@(pos y)."
		box addChild: label.
		box zIndex: 100].
	box addEventHandlerOn: BlMouseLeaveEvent do: [
		box removeChild: label. 
		box zIndex: 1].
		
	^ box
]

{ #category : #accessing }
GT_BA_Examples >> boxWithLabelOnHover: labelContent l: label [
 "create a BlElement with a label poping up when the mouse is over it"
	| box |
	box := BlElement new
		geometry: (BlRectangle cornerRadius: 5);
		background: Color gray;
		size: 50@50;
		clipChildren: false;
		zIndex: 1;
		yourself.
		
	label text: labelContent asRopedText.
		
	box addEventHandlerOn: BlMouseEnterEvent do: [
		"label relocate: (pos x)@(pos y)."
		box addChild: label.
		box zIndex: 100].
	box addEventHandlerOn: BlMouseLeaveEvent do: [
		box removeChild: label. 
		box zIndex: 1].
		
	^ box
]

{ #category : #accessing }
GT_BA_Examples >> boxWithLabelOnHover: labelContent position: pos [
 "create a BlElement with a label poping up when the mouse is over it"
	| box label |
	box := BlElement new
		geometry: (BlRectangle cornerRadius: 5);
		background: Color gray;
		size: 50@50;
		clipChildren: false;
		zIndex: 1;
		yourself.
		
	label := BrLabel new
		look: BrGlamorousLabelLook new glamorousRegularFontAndSize;
		background: Color red;
		text: labelContent;
		zIndex:100.
		
	box addEventHandlerOn: BlMouseEnterEvent do: [
		label relocate: (pos x)@(pos y).
		box addChild: label.
		box zIndex: 100].
	box addEventHandlerOn: BlMouseLeaveEvent do: [
		box removeChild: label. 
		box zIndex: 1].
		
	^ box
]

{ #category : #accessing }
GT_BA_Examples >> colorChangeOnHover [
	<gtExample>
		| box |
		box := BlElement new
			geometry: (BlRectangle cornerRadius: 5);
			size: 100@100;
			background: Color gray;
			yourself.
	
	box addEventHandlerOn: BlMouseEnterEvent do: [box background: Color green].
	box addEventHandlerOn: BlMouseLeaveEvent do: [box background: Color gray].	
	
	^ box
]

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
GT_BA_Examples >> getAllPackages [
	<gtExample>
	^ RPackageOrganizer default
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
GT_BA_Examples >> graphWithPackages [
	<gtExample>
	| view packages |
	
	packages := RPackageOrganizer default packages.
	
	view := GtMondrian new.
	view nodes 
		shape: [ :x | BlElement new
			geometry: (BlRectangle cornerRadius: 0);
			size: (x classes size) @ (x methods size);
			background:Color green];
		with: (packages).
	view layout tree.
	
	^ view
]

{ #category : #accessing }
GT_BA_Examples >> labelOnHover [
	<gtExample>
|	 box box2 |
	box := BlElement new
		geometry: (BlRectangle cornerRadius: 5);
		background: Color green;
		size: 50@50;
		clipChildren: false;
		yourself.
	

	box2 := BrLabel new
		look: BrGlamorousLabelLook new;
		background: Color red;
		size: 20@20.
	
	box addEventHandlerOn: BlMouseEnterEvent do: [
	box2 relocate: ((box position x) + (box size x) + 10)@((box position y )+ (box size y) + 10).
	box addChild: box2].
	box addEventHandlerOn: BlMouseLeaveEvent do: [box removeChild: box2].	


	^box
]

{ #category : #accessing }
GT_BA_Examples >> mondrianWithTextOnHover [
	<gtExample>
	|view |


	view := GtMondrian new.

	view nodes 
		shape: [:x | (GT_BA_Examples new boxWithLabelOnHover: x)];
		with: (1 to: 50).
	
	
	view layout grid.

	^view
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
GT_BA_Examples >> nodesWithGtMondrianClassesAndMethods [
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
				text: 'abc' asRopedText));
				yourself];
		with: (1 to: 10000).
	m layout grid.
	^ m
]

{ #category : #accessing }
GT_BA_Examples >> packageTreeView [
	<gtExample>
	| packagesToDisplay view s packages |
	packagesToDisplay := Set new.
	packagesToDisplay add: 'BA-Testing'.
	packagesToDisplay add: 'GToolkit-Mondrian'.
	packagesToDisplay add: 'IMAD-Cards'.
			
	packages := Set new.
	
	packagesToDisplay do: [ :p | packages add: (RPackageOrganizer default packageNamed: p)].
	
	s := Set new.
	packages do: [ :each | 
		(s add: each). 
		(each definedClasses) do: [:x | s add:x]].

	
	view := GtMondrian new.
	view nodes 
			shape: [ :x | BlElement new
				geometry: (BlRectangle cornerRadius: 0);
				size: ( x isClass
					ifTrue: [(x methods size) @ (x linesOfCode) ]
					ifFalse: [10@10]);
				background:(x isClass
					ifTrue: [Color green]
					ifFalse: [Color red])];
			with: (s).
	view edges connectFrom: [:x | x package].
	
	view layout tree.
			
	^ view
]

{ #category : #accessing }
GT_BA_Examples >> systemComplexityWithPackages [
	<gtExample>
	| view packages |
	
	packages := RPackageOrganizer default packages.
	
	view := GtMondrian new.
	view nodes 
		shape: [ :x | BlElement new
			geometry: (BlRectangle cornerRadius: 0);
			size: (x methods size) @ (x linesOfCode);
			background:(Color r: 0.5 g:0.5 b:0.5 alpha:0.5)];
		with: (packages).
	view layout grid.
	
	^ view
]

{ #category : #accessing }
GT_BA_Examples >> test [
	| box |
	box := BlElement new
		geometry: (BlRectangle cornerRadius: 5);
		background: Color gray;
		size: 50@50;
		clipChildren: false;
		yourself.
		
	box addEventHandlerOn: BlMouseEnterEvent do: [box background: Color green].
	box addEventHandlerOn: BlMouseLeaveEvent do: [box background: Color gray].
		
	^ box
]
