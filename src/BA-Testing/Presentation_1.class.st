Class {
	#name : #'Presentation_1',
	#superclass : #GtSlideShow,
	#category : #'BA-Testing-Presentation'
}

{ #category : #accessing }
Presentation_1 >> crMondrianPointLabelColor [
<gtExample>
	| m |
	m := CRMondrian new.
	m nodes 
		point
		background: [:x | x even ifTrue: [Color green ] ifFalse: [Color red]];
		with: (1 to: 9).
	^m
]

{ #category : #accessing }
Presentation_1 >> gtMondrianPoint [
<gtExample>
	| m |
	m := GtMondrian new.
	m nodes shape: [ :x | BlElement new
			geometry: BlCircle new;
			background: Color black];
			with: (1 to: 9).
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
			with: (1 to: 9).
	^m
]

{ #category : #accessing }
Presentation_1 >> gtMondrianPointLabelColor [
<gtExample>
	| m |
	m := GtMondrian new.
	m nodes shape: [ :x | BlElement new
			geometry: BlCircle new;
			background: ((x even) ifTrue: [Color green] ifFalse: [Color red]);
			aptitude: (BrGlamorousWithTooltipAptitude new
				showDelay: 0;
				hideDelay: 0;
				contentStencil: [BrLabel new aptitude: 
					BrGlamorousLabelAptitude new  
					glamorousRegularFontAndSize;
					alignCenter;
					text: x])
			];
			with: (1 to: 9).
	m layout grid.
	^m
]

{ #category : #accessing }
Presentation_1 >> simplegtMondrian [
<gtExample>
	| m |
	m := GtMondrian new.
	m nodes with: (1 to: 9).
	^m
]

{ #category : #slides }
Presentation_1 >> slide2For: aSlide [
	<gtSlide>
	"Rename this method to be more representative for your slide"
	^ aSlide bulletPoint
		priority: 4;
		title: 'What is Mondrian?';
		bulletPoint: 'Fluent API used to build graphs';
		bulletPoint: 'Second';
		bulletPoint: 'Thrid';
		bulletPoint: 'Forth'
]

{ #category : #slides }
Presentation_1 >> slideMondrianExplanationFor: aSlide [
	<gtSlide>
	^ aSlide textAndElement
		priority: 2;
		newTextWithFormat: ('What is Mondrian' asRopedText 
			fontSize: 30;
			glamorousRegularFont;
			bold);
		newText: 'Mondrian is a fluent API used for data visualization.';
		newText: 'Allows the programmer to write scripts that do the transformation from data to visualization models';
		newText: 'Frist Introduced 1997 by Martin Theus'
]

{ #category : #accessing }
Presentation_1 >> startPresentation [
	<gtExample>
	^GtLiveShow create: Presentation_1 new.
]

{ #category : #accessing }
Presentation_1 >> titleSlideFor: aSlide [
	<gtSlide>
	^ aSlide title
		priority: 1;
		titleWithFormat: ('Implementing Mondrian in Glamorous Toolkit' asRopedText 
			fontSize: 60;
			glamorousRegularFont;
			bold)
]

{ #category : #slides }
Presentation_1 >> whyGtFor: aSlide [
	<gtSlide>
	"Rename this method to be more representative for your slide"
	^ aSlide textAndElement
		priority: 3;
		newTextWithFormat: ('Why use Glamorous Toolkit' asRopedText 
			fontSize: 30;
			glamorousRegularFont;
			bold);
		newText: 'One Rendering Tree';
		newText: 'Moldable Development'
]
