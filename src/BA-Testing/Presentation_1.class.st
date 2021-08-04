Class {
	#name : #'Presentation_1',
	#superclass : #GtSlideShow,
	#category : #'BA-Testing-Presentation'
}

{ #category : #accessing }
Presentation_1 >> classesAsCollection [
	| col |
	col := OrderedCollection new.
	col addAll: CRShapeBuilder subclasses.
	col add: CRShapeBuilder.
	^col
]

{ #category : #accessing }
Presentation_1 >> crMondrianPointLabelColor [
<gtExample>
	| m |
	m := CRMondrian new.
	m nodes 
		point
		with: self classesAsCollection.
	m edge arrow; connectFrom: #superclass.
	m layout tree.
	^m 
]

{ #category : #accessing }
Presentation_1 >> crMondrianWithMethods [
<gtExample>
	| m |
	m := CRMondrian new.
	m nodes 
		mondrianNodes
		stencil: [ :p | | v |
			v := CRMondrian new .
			v nodes 
				box
				toolTip: #name; 
				with: (p methods ).
			v
			];
		with: self classesAsCollection.
	m edge arrow; forAll: [:x | x isClass]; connectFrom: #superclass.
	m layout tree.
	^m 
]

{ #category : #accessing }
Presentation_1 >> createMondrianExplainView [
<gtExample>
	| x m e1 e2 container line e3 |
	x:= OrderedCollection new.
x addAll: CRNode subclasses. 
x add: CRNode.

m := CRMondrian new.
m nodes label with: x.
m edge connectFrom: #superclass.
m layout tree.

e1 := (((x) gtViewsFor: GtPhlowView empty) 
			asElementDo: [:e | 
				BlElement new 
					aptitude: BrShadowAptitude; 
					background: Color white;
					margin: (BlInsets all: 20);
					addChild: e]) size: 400@300; relocate: 140@40.

e2 := (((m) gtViewsFor: GtPhlowView empty) 
			asElementDo: [:e | 
				BlElement new 
					aptitude: BrShadowAptitude; 
					background: Color white;
					margin: (BlInsets all: 20);
					addChild: e]) size: 600@250; relocate: 50@700.

e3 := (((Presentation_1>>#methodForMondrianExplain) gtViewsFor: GtPhlowView empty) 
			asElementDo: [:e | 
				BlElement new 
					aptitude: BrShadowAptitude; 
					background: Color white;
					margin: (BlInsets all: 20);
					addChild: e]) size: 600@340; relocate: 400@330.
					
line := CRArrowElement new 
	border: (BlBorder paint: (Color black) width: (10));
	fromAnchor: (BlNearestPositionBoundsAnchor nearestTo: e2 from: e1);
	toAnchor: (BlNearestPositionBoundsAnchor nearestTo: e1 from: e2).

container := BlElement new
	size: 1050@1000;
	clipChildren: false;
	zIndex: -1.
	
container addChildren: {e1. e2. e3. line.}.
	
^container
]

{ #category : #slides }
Presentation_1 >> demoSlide2: aSlide [
	<gtSlide>
	^ aSlide element
		priority: 5;
		element: [ (GtPlaygroundLiveSlide new snippets: {
		'| m |
classes := OrderedCollection new. classes addAll: CRNode subclasses. classes add: CRNode.
m := CRMondrian new.
m nodes 
	mondrianNodes
	stencil: [ :p | | v |
		v := CRMondrian new .
		v nodes 
			box
			toolTip: #name; 
			with: (p methods ).
		v
		];
	with: classes.
m edge arrow; forAll: [:x | x isClass]; connectFrom: #superclass.
m layout tree.
m'
		}) create ]
]

{ #category : #slides }
Presentation_1 >> demoSlide: aSlide [
	<gtSlide>
	^ aSlide element
		priority: 4;
		element: [ (GtPlaygroundLiveSlide new snippets: {
		'classes := OrderedCollection new. 
classes addAll: CRNode subclasses. 
classes add: CRNode.'.

		}) create ]
]

{ #category : #slides }
Presentation_1 >> explainSlide: aSlide [
	<gtSlide>
	"Rename this method to be more representative for your slide"
	^ aSlide text
		priority: 6;
		newTextWithFormat: ('How does it work' asRopedText glamorousRegularFont; fontSize: 40; bold);
		newTextWithFormat: ('Main Components:
		- CRMondrian is the base element that holds and creates all other elements
		- Canvas holds all nodes and edges and is displayed to the user
		- Builders for nodes, edges and layouts
The elements (nodes, edges and canvas) are instances of BlElement and created just before beeing displayed' asRopedText glamorousRegularFont; fontSize: 27)
]

{ #category : #accessing }
Presentation_1 >> gtMondrianPoint [
<gtExample>
	| m |
	m := GtMondrian new.
	m nodes shape: [ :x | BlElement new
			geometry: BlCircle new;
			background: Color black];
			with: self classesAsCollection.
	^m
]

{ #category : #accessing }
Presentation_1 >> gtMondrianPointLabel [
<gtExample>
	| m |
	m := GtMondrian new.
	m nodes shape: [ :x | BlElement new
			geometry: BlCircle new;
			background: 
			Color black;
		 	aptitude: (BrGlamorousWithTooltipAptitude new
				showDelay: 0;
				hideDelay: 0;
				contentStencil: [BrLabel new aptitude: 
					BrGlamorousLabelAptitude new  
					glamorousRegularFontAndSize;
					alignCenter;
					text: x])
			];
			with: self classesAsCollection.
	m layout grid.
	^m
]

{ #category : #accessing }
Presentation_1 >> gtMondrianPointLabelColor [
<gtExample>
	| m |
	m := GtMondrian new.
	m nodes shape: [ :x | BlElement new
			geometry: BlCircle new;
			background: Color black;
			aptitude: (BrGlamorousWithTooltipAptitude new
				showDelay: 0;
				hideDelay: 0;
				contentStencil: [BrLabel new aptitude: 
					BrGlamorousLabelAptitude new  
					glamorousRegularFontAndSize;
					alignCenter;
					text: x])
			];
			with: self classesAsCollection.
	m edges connectFrom: #superclass.
	m layout tree.
	^m
]

{ #category : #accessing }
Presentation_1 >> methodForMondrianExplain [
<gtExample>
	| view coll |
	coll:= self classesAsCollection.
	view := CRMondrian new.
	view nodes label with: (coll).
	view edge connectFrom: #superclass.
	view layout tree.
	^ view
]

{ #category : #slides }
Presentation_1 >> mondrianSlideFor: aSlide [
	<gtSlide>
	^ aSlide textAndElement
		priority: 2;
		newTextWithFormat: ('What is Mondrian' asRopedText 
			fontSize: 40;
			glamorousRegularFont;
			bold);
		newTextWithFormat: ('- Framework to build interactive visualizations' asRopedText
			fontSize: 27;
			glamorousRegularFont);
		newTextWithFormat: ('- Allows the programmer to create complex visualizations with easy scripts'asRopedText
			fontSize: 27;
			glamorousRegularFont);
		newTextWithFormat: ('- Mondrian helps overcome the gap between data and visualization'asRopedText
			fontSize: 27;
			glamorousRegularFont);
		element: [BlElement new addChild: (self createMondrianExplainView asScalableElement fitAll) ]
]

{ #category : #accessing }
Presentation_1 >> nil [
]

{ #category : #slides }
Presentation_1 >> questionsSlideFor: aSlide [
	<gtSlide>
	^ aSlide title
		priority: 8;
		titleWithFormat: ('Questions?' asRopedText fontSize: 70; glamorousRegularFont; bold)
]

{ #category : #accessing }
Presentation_1 >> simplegtMondrian [
<gtExample>
	| m |
	m := GtMondrian new.
	m nodes with: self classesAsCollection.
	^m
]

{ #category : #accessing }
Presentation_1 >> startPresentation [
	<gtExample>
	^GtLiveShow createWithArrowsVisible: Presentation_1 new.
]

{ #category : #slides }
Presentation_1 >> titleSlide: aSlide [
	<gtSlide>
	^ aSlide title
		priority: 1;
		titleWithFormat: ('Implementing Mondrian in Glamorous Toolkit' asRopedText 
			fontSize: 60;
			glamorousRegularFont;
			bold)
]

{ #category : #slides }
Presentation_1 >> whatsLeftSlide: aSlide [
	<gtSlide>
	"Rename this method to be more representative for your slide"
	^ aSlide text
		priority: 7;
		
		newTextWithFormat: ('Whats left to do' asRopedText glamorousRegularFont; fontSize: 40; bold);
		newTextWithFormat: ('- Add some more features and finish the implementation
- Improve the performance
- Add propper class comments with examples
- Write the thesis and documentation' asRopedText glamorousRegularFont; fontSize: 27)
]

{ #category : #slides }
Presentation_1 >> whyGtSlide: aSlide [
	<gtSlide>
	^ aSlide textAndElement
		priority: 3;
		newTextWithFormat: ('Why Glamorous Toolkit' asRopedText 
			fontSize: 40;
			glamorousRegularFont;
			bold);
		newTextWithFormat: ('One Rendering Tree
			- The UI and the canvas of a visualization exits in the 
				same world
			- This allows interaction between UI and visualizations
			' asRopedText
			fontSize: 27;
			glamorousRegularFont);
		newTextWithFormat: ('Moldable Development
			- Different things should look different' asRopedText
			fontSize: 27;
			glamorousRegularFont);
		element: [GtCustomViewsLiveSlide new asElement]
]
