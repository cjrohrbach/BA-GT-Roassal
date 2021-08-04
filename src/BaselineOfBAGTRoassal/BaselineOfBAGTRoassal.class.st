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
		do: [ 
		
			spec 
				baseline: 'Graphviz4GT'
				with: [spec repository: 'github://rafibu/Graphviz4GT/src'].
			
			spec
				package: #'BA-Testing';
				package: #'GT-Roassal';
				package: #'CR-Graph';
				package: #'CR-Graph-Graphviz'
				 ]
]

{ #category : #accessing }
BaselineOfBAGTRoassal >> testWithoutgraphviz: spec [
	spec
		for: #common
		do: [
			spec 
				package: #'CR-Graph'	
		]
]
