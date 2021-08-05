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
				with: [ spec repository: 'github://rafibu/Graphviz4GT/src' ].
				
			spec 
				baseline: 'MyMoldableRequirements'
				with: [ spec repository: 'github://nitishspatkar/moldable-requirements:scheduling' ].
			
			spec
				package: #'BA-Testing';
				package: #'GT-Roassal';
				package: #'CR-Graph';
				package: #'CR-Graph-Graphviz';
				package: #'CR-Graph-MindMapExample'.
			spec 
				group: 'default' with: #('core');
				group: 'core' with: #(#'CR-Graph');
				group: 'withGraphviz' with: #(#'default' 'Graphviz4GT' #'CR-Graph-Graphviz');
				group: 'withHospitalExample' with: #('default' 'MyMoldableRequirements' #'CR-Graph-MindMapExample')
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
