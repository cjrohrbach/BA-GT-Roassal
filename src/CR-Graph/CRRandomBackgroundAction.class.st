"
I am a Action that changes the background color of the node when clicked on it.
I'm actually only intended to use for testing, but can be used if someone would like to have this functionallity.


{{gtExample:CRMondrianExamples>>#randomBackgroundAction|previewExpanded=true|codeExpanded=false}}
"
Class {
	#name : 'CRRandomBackgroundAction',
	#superclass : 'CRAction',
	#category : 'CR-Graph-Action'
}

{ #category : 'initialization' }
CRRandomBackgroundAction >> initialize [
	super initialize.
	event := BlClickEvent.
	block := [:e | 
	
		e target background: Color random
		
	].
	^self
]
