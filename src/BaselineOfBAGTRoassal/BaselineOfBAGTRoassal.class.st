Class {
	#name : #BaselineOfBAGTRoassal,
	#superclass : #BaselineOf,
	#category : #BaselineOfBAGTRoassal
}

{ #category : #baselines }
BaselineOfBAGTRoassal >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: #'BA-Testing';
				package: #'GT-Roassal' ]
]
