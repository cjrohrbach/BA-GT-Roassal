"
I implement a prime sieve. When I'm added to a mondrian all nodes will receive a Eventhandler that works as a prime sive.
"
Class {
	#name : 'CRPrimeSieveAction',
	#superclass : 'CRAction',
	#instVars : [
		'nonPrimeColor',
		'primeColor'
	],
	#category : 'CR-Graph-Action'
}

{ #category : 'accessing' }
CRPrimeSieveAction >> blo [
"I create the block used for a prime sieve action"
| b |
b := [:e | | node multiples sorted |

	(e target class = CRNode) ifTrue: [node := e target]
		ifFalse: [
			(e target parent class = CRNode) ifTrue: [node := e target parent]
		].
	
	
	
	(node model = 1) ifTrue: [ node centerElement background: nonPrimeColor ]
	ifFalse: [
		(node centerElement background class = BlTransparentBackground)
			ifTrue: [
				sorted := false.
			]
			ifFalse: [
				sorted := ((node centerElement background paint color) = nonPrimeColor).
			].
		sorted ifFalse: [
			node centerElement background: primeColor.
			multiples := OrderedCollection new.
			node group do: [ :n | 
				((n model \\ node model) = 0) ifTrue: [
						multiples add: n.
					].
			].
			multiples allButFirst do: [:n | n centerElement background: nonPrimeColor].
		].
	].
].
^b
]

{ #category : 'initialization' }
CRPrimeSieveAction >> initialize [
	super initialize.
	
	primeColor := Color blue.
	nonPrimeColor := Color lightGray.
	
	event := BlClickEvent.
	block :=  self blo.
	
	^self
]
