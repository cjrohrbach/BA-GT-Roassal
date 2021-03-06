"
CRLabel is the element used for {{gtClass:CRMondrian}} label nodes.


{{gtExample:CRLabel>>#example|codeExpanded=false|previewExpanded=true}}

"
Class {
	#name : 'CRLabel',
	#superclass : 'BlTextElement',
	#instVars : [
		'model',
		'modelAsText'
	],
	#category : 'CR-Graph-NodeShape'
}

{ #category : 'accessing' }
CRLabel >> aptitude: aLook [
"Tooltips on labels don't make sense"
	(aLook class = BrGlamorousWithTooltipAptitude) ifFalse:
		[super aptitude: aLook]
]

{ #category : 'accessing' }
CRLabel >> content: something [
"define the text I should show"
	modelAsText := false.
	self text: something asRopedText glamorousRegularFont.
]

{ #category : 'accessing' }
CRLabel >> example [
"I am an example for my class comment"
	<gtExample>
	^CRLabel new
]

{ #category : 'initialization' }
CRLabel >> initialize [
	super initialize.
	
	self background: Color white.
	"self margin: (BlInsets all: 10)."
	self padding: (BlInsets all: 5).
	"self effect: (BlGaussianShadowEffect color: (Color gray alpha: 0.5) width: 2 offset: 0@0)."
	self border: (BlBorder paint: (Color black) width: 0.3).
	
	modelAsText := true.
	^self
]

{ #category : 'accessing' }
CRLabel >> model [
"I am a getter method for the model"
	^model
]

{ #category : 'accessing' }
CRLabel >> model: anObject [
"I am a setter method for the model. I add the model as toolTipContent and as text that I display"
	model := anObject.
	modelAsText ifTrue: [self text: model asRopedText glamorousRegularFont].
]

{ #category : 'accessing' }
CRLabel >> requiersModel [
"
	Since my text should correspond with the model I represent, I require the model
"

	^true
]
