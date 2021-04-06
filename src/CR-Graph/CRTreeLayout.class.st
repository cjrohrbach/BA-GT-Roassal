Class {
	#name : #CRTreeLayout,
	#superclass : #GtGradVerticalTreeLayout,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRTreeLayout >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRTreeLayout >> on: aCanvas [
	aCanvas layout: (BlOnceLayout new layout: self).
]
