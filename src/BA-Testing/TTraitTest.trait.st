Trait {
	#name : #TTraitTest,
	#instVars : [
		'abc'
	],
	#category : #'BA-Testing-TraitTesting'
}

{ #category : #accessing }
TTraitTest >> abc [
	^abc
]

{ #category : #accessing }
TTraitTest >> abc: something [
	abc := something
]

{ #category : #accessing }
TTraitTest >> changeColor [
	self background: Color random.
]
