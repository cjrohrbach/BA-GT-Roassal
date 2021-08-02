Extension { #name : #BlElement }

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
BlElement >> holdsNodes [
	"I return true if I have nodes as children.
	If this is the case I have to implement a removeHighlight method that removes all highlights from my nodes.
	"
	
	^false
	
]

{ #category : #'*CR-Graph' }
BlElement >> requiersModel [
"
	Default is false.
	If the element displays the model (i.e. BlTextElement) this should be overriten to return true.	
"
	^false
]
