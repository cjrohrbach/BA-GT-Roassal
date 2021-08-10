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
CompiledMethod >> classBlueprintColorCategory [
	(self isSubclassResponsibility) ifTrue: [^#abstract].
	(self variableNodes contains: [:x | x class = RBSuperNode]) 
		ifTrue: [^#extending] 
		ifFalse: [(self overriddenMethods size > 0) ifTrue: [^#overriding]].
	(self isDelegation) ifTrue: [^#delegating].
	(self returnsConstant) ifTrue: [^#constant].
	^#false
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
CompiledMethod >> isDelegation [
	(self ast body children size = 1) ifTrue:[
		(self variableNodes contains: [:x | x class = RBInstanceVariableNode or: x class = RBSelfNode]) ifTrue: [
			(self messages size > 0) ifTrue: [
				^true.
			].
		].
	].
	^false
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
CompiledMethod >> isExternalInterfaceMethod [
	^(self isInitialization not) and: ((self isAccessor or: self isSetter) not) and: (self isImplementationLayerMethod not)
]

{ #category : #'*CR-Graph' }
CompiledMethod >> isImplementationLayerMethod [
	
	self methodClass methods do: [:m |
		(m messages includes: self selector) ifTrue: [	
			(m isInitialization) ifFalse: [^true]
		].
	].
	^false
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
	((self ast ir numArgs) = 0 ) ifTrue: [
	
		(self ast addReturn value class = RBLiteralValueNode) ifTrue: [^true]
	].
	^false
]

{ #category : #'*CR-Graph' }
CompiledMethod >> sendersInPackage: aPackage [
	^aPackage classes flatCollect: [ :class | 
			(class thoroughWhichMethodsReferTo: (self selector)) collect: [ :method | method methodReference ] ]
]

{ #category : #'*CR-Graph' }
CompiledMethod >> sendersInPackageCollection: aPackageCollection [
	^aPackageCollection flatCollect: [ :package | 
			self sendersInPackage: package
			]
]
