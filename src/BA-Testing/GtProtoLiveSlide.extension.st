Extension { #name : 'GtProtoLiveSlide' }

{ #category : '*BA-Testing' }
GtProtoLiveSlide >> bulletPoint [
	^ GtBulletpointSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]
