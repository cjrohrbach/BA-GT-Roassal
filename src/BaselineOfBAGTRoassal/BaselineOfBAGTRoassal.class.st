Class {
	#name : #BaselineOfBAGTRoassal,
	#superclass : #BaselineOf,
	#category : #BaselineOfBAGTRoassal
}

{ #category : #accessing }
BaselineOfBAGTRoassal >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec 
				package: #'CR-Graph'	
		]
]

{ #category : #accessing }
BaselineOfBAGTRoassal >> baselineCRGraph: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec 
				package: #'CR-Graph'	
		]
]

{ #category : #baselines }
BaselineOfBAGTRoassal >> baselineForDev: spec [
	<baseline>
	spec
		for: #dev
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
BaselineOfBAGTRoassal >> baselineWithoutGraphviz: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec 
				package: #'CR-Graph'	
		]
]

{ #category : #accessing }
BaselineOfBAGTRoassal >> testWithoutgraphviz: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec 
				package: #'CR-Graph'	
		]
]
