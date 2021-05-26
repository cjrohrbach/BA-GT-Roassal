Extension { #name : #CompiledMethod }

{ #category : #'*CR-Graph' }
CompiledMethod >> isAccessor [
	| ast seq ret var |
	ast := self ast.
	ast children size = 1 ifFalse: [ ^ false ].
	
	seq := ast children first.
	seq class == RBSequenceNode ifFalse: [ ^ false ].
	
	seq children size = 1 ifFalse: [ ^ false ].
	ret := seq children first.
	ret class == RBReturnNode ifFalse: [ ^ false ].
	
	
	var := ret children first.
	var class == RBVariableNode ifFalse: [ ^ false ].
	
	^ self selector = var name
]

{ #category : #'*CR-Graph' }
CompiledMethod >> isSetter [
	| ast seq ass |
	ast := self ast.
	ast children size = 2 ifFalse: [ ^ false ].
 
	seq := ast children second.
	seq class == RBSequenceNode ifFalse: [ ^ false ].
	seq children size = 1 ifFalse: [ ^ false ].
	
	ass := seq children first.
	ass children size = 2 ifFalse: [ ^ false ].
	ass children second class == RBVariableNode ifFalse: [ ^ false ].
	^ self methodClass instVarNames includes: ass children second name
]

{ #category : #'*CR-Graph' }
CompiledMethod >> test12434 [
	^'test'
]
