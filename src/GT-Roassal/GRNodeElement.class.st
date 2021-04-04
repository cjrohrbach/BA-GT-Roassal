Class {
	#name : #GRNodeElement,
	#superclass : #BlElement,
	#category : #'GT-Roassal-GT-Roassal'
}

{ #category : #accessing }
GRNodeElement >> addHoverEffekt: originalColor effectColor: aColor [
	self addEventHandlerOn: BlMouseEnterEvent do: [self background: aColor].
	self addEventHandlerOn: BlMouseLeaveEvent do: [self background: originalColor].
]

{ #category : #accessing }
GRNodeElement >> addToolTip: labelText [
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
GRNodeElement >> initialize [
	super initialize.
	^ self
]
