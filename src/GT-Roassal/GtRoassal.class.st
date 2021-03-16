Class {
	#name : #GtRoassal,
	#superclass : #GtMondrian,
	#instVars : [
		'nodeShape',
		'nodeCollection',
		'mondrianInst',
		'nodeLayout'
	],
	#category : #'GT-Roassal'
}

{ #category : #accessing }
GtRoassal >> build [
	mondrianInst nodes 
		shape: nodeShape;
		with: nodeCollection.
	mondrianInst layout grid.
]

{ #category : #accessing }
GtRoassal >> circle [
	^ (BlElement new 
		geometry: BlEllipseGeometry new;
				border: (BlBorder paint: Color black width: 2);
				size: 50 asPoint)
]

{ #category : #accessing }
GtRoassal >> gtLiveFor: aView [
	<gtView>
	^ mondrianInst gtLiveFor: aView
]

{ #category : #accessing }
GtRoassal >> initialize [
	mondrianInst := GtMondrian new.
	^ self
]

{ #category : #accessing }
GtRoassal >> layout [ 
	nodeLayout := 'grid'.
]

{ #category : #accessing }
GtRoassal >> nodes [
	nodeCollection := (1 to: 10).
]

{ #category : #accessing }
GtRoassal >> shape [
	nodeShape := [BlElement new 
		geometry: BlEllipseGeometry new;
		border: (BlBorder paint: Color black width: 2);
		size: 50 asPoint].
	
]

{ #category : #accessing }
GtRoassal >> stack [
	^ mondrianInst stack
]
