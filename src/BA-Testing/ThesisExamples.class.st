Class {
	#name : 'ThesisExamples',
	#superclass : 'Object',
	#category : 'BA-Testing-Thesis'
}

{ #category : 'accessing' }
ThesisExamples >> gTMondrianNesting [
	<gtExample>
	| view |

	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			BlElement new  
				border: (BlBorder paint: (Color black) width: 2);
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent.
				];
				margin: (BlInsets all: 20) ];
		with: (CRMondrian package classes)
		forEach: [ :each |
			view nodes 
				shape: [ :x | BlElement new
					background: Color black;
					margin: (BlInsets all: 5).
				 ];
				with: (each methods).
				view layout grid.
			].
			
	^view
]

{ #category : 'accessing' }
ThesisExamples >> gTMondrianNestingTooltip [
	<gtExample>
	| view |

	view := GtMondrian new.
	view nodes
		shape: [ :x | 
			BlElement new  
				border: (BlBorder paint: (Color black) width: 2);
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal fitContent.
				];
				margin: (BlInsets all: 20);
				aptitude: (BrGlamorousWithTooltipAptitude new
				showDelay: 0;
				hideDelay: 0;
				contentStencil: [BrLabel new aptitude: 
					BrGlamorousLabelAptitude new  
					glamorousRegularFontAndSize;
					alignCenter;
					text: x])
				];
		with: (CRMondrian package classes)
		forEach: [ :each |
			view nodes 
				shape: [ :x | BlElement new
					background: Color black;
					margin: (BlInsets all: 5);
					aptitude: (BrGlamorousWithTooltipAptitude new
					showDelay: 0;
					hideDelay: 0;
					contentStencil: [BrLabel new aptitude: 
						BrGlamorousLabelAptitude new  
						glamorousRegularFontAndSize;
						alignCenter;
					text: x])
				 ];
				with: (each methods).
				view layout grid.
			].
			
	^view
]
