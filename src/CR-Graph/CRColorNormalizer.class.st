Class {
	#name : #CRColorNormalizer,
	#superclass : #CRNormalizer,
	#instVars : [
		'highColor',
		'lowColor'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRColorNormalizer >> highColor: aColorOrBlock [
	highColor := aColorOrBlock
]

{ #category : #accessing }
CRColorNormalizer >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRColorNormalizer >> lowColor: aColorOrBlock [
	lowColor := aColorOrBlock
]
