Class {
	#name : #'GR_NodeElement',
	#superclass : #BlElement,
	#category : #'GT-Roassal-GT-Roassal'
}

{ #category : #accessing }
GR_NodeElement >> addHoverEffekt: originalColor effectColor: aColor [
	self addEventHandlerOn: BlMouseEnterEvent do: [self background: aColor].
	self addEventHandlerOn: BlMouseLeaveEvent do: [self background: originalColor].
]

{ #category : #accessing }
GR_NodeElement >> addToolTip: labelText [
	| label |
	label := [BrLabel new aptitude: 
		BrGlamorousLabelAptitude new  
			glamorousRegularFontAndSize;
			alignCenter;
			text: labelText].
		
	self aptitude: (BrGlamorousWithTooltipAptitude new
		showDelay: 0;
		hideDelay: 0;
		contentStencil: label)
]

{ #category : #accessing }
GR_NodeElement >> initialize [
	super initialize.
	^ self
]
