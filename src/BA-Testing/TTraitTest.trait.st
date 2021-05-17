Trait {
	#name : #TTraitTest,
	#category : #'BA-Testing-TraitTesting'
}

{ #category : #accessing }
TTraitTest >> changeColor [
	self background: Color random.
]
