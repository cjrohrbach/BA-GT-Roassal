Class {
	#name : #GtBulletpointSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'title',
		'points'
	],
	#category : #'BA-Testing-Presentation'
}

{ #category : #accessing }
GtBulletpointSlide >> bulletPoint: aText [
	| b |
	"b := BlElement new
		constraintsDo: [:c |
		c horizontal fitContent.
		c vertical fitContent ].
	b addChild: (BlElement new
		geometry: BlCircle new;
		background: Color black;
		size: 10 asPoint)."
	"b addChild: (BrEditor new
			aptitude: (BrGlamorousEditorAptitude new lineSpacing: 5);
			margin: (BlInsets all: 50);
			hMatchParent;
			vFitContent;
			text: (aText asRopedText glamorousRegularFont; fontSize: 20);
			beReadOnlyWithSelection)."
	points add: aText.
	
]

{ #category : #accessing }
GtBulletpointSlide >> create [
	| container textContainer texts pointsContainer |
	container := BlElement new
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets top: 20 bottom: 20);
		layout: BlLinearLayout vertical alignCenter.

	pointsContainer := BlElement new
		constraintsDo: [:c |
			c vertical fitContent.
			c horizontal fitContent ];
		layout: ((BlGridLayout new columnCount: 2; cellSpacing: 10)).

	points do: [:p |
		pointsContainer addChild: (BlElement new
			constraintsDo: [:c | c horizontal fitContent.];
			layout: BlLinearLayout vertical alignCenter;
			addChild: (BlElement new
				geometry: BlCircle new;
				background: Color black;
				size: 10 asPoint)).
		
		pointsContainer addChild: (BlElement new
			constraintsDo: [:c | c horizontal fitContent.];
			layout: BlLinearLayout vertical alignCenter;
			addChild: (BrEditor new
				aptitude: (BrGlamorousEditorAptitude new lineSpacing: 5);
				hFitContent;
				vFitContent;
			text: (p asRopedText glamorousRegularFont; fontSize: 20);
			beReadOnlyWithSelection)).
			
			
			
			
			"BlTextElement new
			text: (p asRopedText glamorousRegularFont; fontSize: 20))
			)."
	].


	title := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent.
			c linear vertical alignCenter ];
		layout: BlLinearLayout vertical;
		addChild: (BlTextElement new 
			constraintsDo: [ :c |
				c linear horizontal alignCenter ];
			padding: (BlInsets top: 40; bottom: 20);
			text: title).

			
	container addChild: title.
	container addChild: pointsContainer.
	^container
]

{ #category : #accessing }
GtBulletpointSlide >> initialize [
	super initialize.
	points := OrderedCollection new.
]

{ #category : #accessing }
GtBulletpointSlide >> title: aTitle [
	title := aTitle asRopedText fontSize: 30; glamorousRegularFont
]
