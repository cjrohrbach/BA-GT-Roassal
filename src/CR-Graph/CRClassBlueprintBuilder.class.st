Class {
	#name : #CRClassBlueprintBuilder,
	#superclass : #CRShapeBuilder,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRClassBlueprintBuilder >> test [
<gtExample>
| c init instance implementor accessor attribute |

c := BlElement new
	border: (BlBorder paint: Color red width: 1);
	size: (140@240);
	
	clipChildren: false.
c properties 
			addProperty: (BlElementLayoutHorizontalResizerProperty new fitContent);
			addProperty: (BlElementLayoutVerticalResizerProperty new fitContent).

init := BlElement new
	size: 100@200;
	margin: (BlInsets all: 20);
	border: (BlBorder paint: Color black width: 0.5).			
			
instance := BlElement new
	size: 100@200;
	margin: (BlInsets all: 20);
	border: (BlBorder paint: Color black width: 0.5).
	
implementor := BlElement new
	size: 100@200;
	margin: (BlInsets all: 20);
	border: (BlBorder paint: Color black width: 0.5).

accessor := BlElement new
	size: 100@200;
	margin: (BlInsets all: 20);
	border: (BlBorder paint: Color black width: 0.5).
	
attribute := BlElement new
	size: 100@200;
	margin: (BlInsets all: 20);
	border: (BlBorder paint: Color black width: 0.5).

c addChild: init.
c addChild: instance.
c addChild: implementor.
c addChild: accessor.
c addChild: attribute.
c layout: (BlGridLayout new).
^c
]
