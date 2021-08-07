Extension { #name : #InstanceVariableSlot }

{ #category : #'*CR-Graph' }
InstanceVariableSlot >> numberOfAccessesWithin: aMethodCollection [
	| counter |
	counter := 0.
	aMethodCollection do: [:m | 
		(self isAccessedIn: m) ifTrue: [counter := counter + 1]
	].
	
	^counter
]
