Extension { #name : #BlElement }

{ #category : #'*CR-Graph' }
BlElement >> addRedBorder [
	self children do: [:c |
		c border: (BlBorder paint: (Color red) width: 0.5).
		c addRedBorder.
	]
]

{ #category : #'*CR-Graph' }
BlElement >> el_ToggleDebugView [
	
	(self userData at: #isDebugViewActive ifAbsentPut: false) ifTrue: [
		self border: (self userData at: #originalBorder ifAbsentPut: (BlBorder empty)).
		self children do: [:c | c el_ToggleDebugView].
		self userData at: #isDebugViewActive put: false.
	] ifFalse: [
		self userData at: #originalBorder put: (self border).
		self border: (BlBorder paint: (Color red) width: 1).
		self children do: [:c | c el_ToggleDebugView].
		self userData at: #isDebugViewActive put: true.
	]
]

{ #category : #'*CR-Graph' }
BlElement >> requiersModel [
"
	Default is false.
	If the element displays the model (i.e. BlTextElement) this should be overriten to return true.	
"
	^false
]

{ #category : #'*CR-Graph' }
BlElement >> toggleDebugView [
	
	(self userData at: #isDebugViewActive ifAbsentPut: [false]) ifTrue: [
		self border: (self userData at: #originalBorder).
		self userData at: #isDebugViewActive put: [false]
	] ifFalse: [
		self userData at: #originalBorder put: [self border].
		self border: (BlBorder paint: (Color red) width: 1).
		self children do: [:c | c toggleDebugView].
		self userData at: #isDebugViewActive put: [true].
	]
]
