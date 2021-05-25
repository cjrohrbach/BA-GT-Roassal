"
I implement a prime sieve. When I'm added to a mondrian all nodes will receive a Eventhandler that works as a prime sive.
"
Class {
	#name : #CRPrimeSieveAction,
	#superclass : #CRAction,
	#instVars : [
		'nonPrimeColor',
		'primeColor'
	],
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRPrimeSieveAction >> blo [
| b |
b := [:e | | node multiples sorted |

	node := e target.
	(node model = 1) ifTrue: [ node background: nonPrimeColor ]
	ifFalse: [
		(node background class = BlTransparentBackground)
			ifTrue: [
				sorted := false.
			]
			ifFalse: [
				sorted := ((node background paint color) = nonPrimeColor).
			].
		sorted ifFalse: [
			node background: primeColor.
			multiples := OrderedCollection new.
			node group do: [ :n | 
				((n model \\ node model) = 0) ifTrue: [
						multiples add: n.
					].
				"(n ~= node) ifTrue: [
					
				]."
			].
			multiples allButFirst do: [:n | n background: nonPrimeColor].
		].
	].
].
^b
]

{ #category : #accessing }
CRPrimeSieveAction >> initialize [
	super initialize.
	
	primeColor := Color blue.
	nonPrimeColor := Color lightGray.
	
	event := BlClickEvent.
	block :=  self blo.
	
	"[:e | | node multiples |
		e consumed: true.
		node := e target.
		(node background paint color = nonPrimeColor) ifTrue: [
			""the node was already categroised as non prime""
			
		]
		ifFalse: [
			node background: primeColor.
			multiples := node group select: [:x | (x model \\ node model) = 0 ].
			multiples allButFirst do: [:m | m background: nonPrimeColor].
		]
		
	]."
	^self
]
