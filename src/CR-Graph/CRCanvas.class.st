Class {
	#name : #CRCanvas,
	#superclass : #Object,
	#instVars : [
		'shapes'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRCanvas >> add: aShape [
	shapes add: aShape
]

{ #category : #accessing }
CRCanvas >> gtLiveFor: aView [
	<gtView>
	^ aView list
		title: 'Shape List' translated;
		priority: 8;
		items: [ shapes ].
]

{ #category : #accessing }
CRCanvas >> initialize [
	shapes := CRGroup new.
]
