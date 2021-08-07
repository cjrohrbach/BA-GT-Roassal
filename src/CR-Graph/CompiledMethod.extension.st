Extension { #name : #CompiledMethod }

{ #category : #'*CR-Graph' }
CompiledMethod >> callingMethodsIn: someClasses [
" I collect and return all methods in the provided classes that call this method "

	| callers someMethods |
	
	someMethods := someClasses flatCollect: [:cls | cls methods].
	callers := someMethods collect: [ :cm |
		(cm messages includes: self selector) ifTrue: [ cm ] 
	] thenSelect: [:cm | cm  ~= nil].
	
	^callers
	
]

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
	var class == RBInstanceVariableNode ifFalse: [ ^ false ].
	
	^ self selector = var name
]

{ #category : #'*CR-Graph' }
CompiledMethod >> isExtendingMethod [
	"
	Returns true if this method extends another method.
	This is determined by searching for a super call.
	"
	
	^self variableNodes contains: [:x | x class = RBSuperNode]
	
]

{ #category : #'*CR-Graph' }
CompiledMethod >> isInitialization [
	"Return ture if I am a method used for initialization, meaning my protocol or name includes the substring init.
	"
	(self protocol includesSubstring:'init' ) ifTrue: [^true].
	(self name includesSubstring: 'init') ifTrue: [^true].
	^false
]

{ #category : #'*CR-Graph' }
CompiledMethod >> isPrivateIn: someClasses [
	"Return true if I am public, i.e., at least one method that is not in my class may call me
	
	(CompiledMethod >> #isPublic) isPublic
	"
	^ (self isPublicIn: someClasses) not
]

{ #category : #'*CR-Graph' }
CompiledMethod >> isPublicIn: someClasses [
	"Return true if I am public, i.e., at least one method that is not in my class may call me
	
	(CompiledMethod >> #isPublic) isPublic
	"
	
	| someCompiledMethods |
	someCompiledMethods := someClasses flatCollect: [ :cls | cls methods ].
	someCompiledMethods do: [ :cm | 
		(((cm messages includes: self selector) and: [ cm methodClass ~~ self methodClass ]) and: [ cm selector ~= #DoIt ]) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'*CR-Graph' }
CompiledMethod >> isPureOverridingMethod [
	"
		Return true if this method overrides a method without calling its super method.
	"
	
	^(self overriddenMethods size > 0) and: (self isExtendingMethod not)
	
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
	ass children second class == RBInstanceVariableNode ifFalse: [ ^ false ].
	^ self methodClass instVarNames includes: ass children second name
]

{ #category : #'*CR-Graph' }
CompiledMethod >> returnsConstant [
	"
		Return true If I return a constant value
	"
	
]
