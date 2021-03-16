Class {
	#name : #GtRoassal,
	#superclass : #GtMondrian,
	#instVars : [
		'nodeShape',
		'nodeCollection',
		'mondrianInst'
	],
	#category : #'GT-Roassal'
}

{ #category : #accessing }
GtRoassal >> build [
	^ mondrianInst nodes  shape: nodeShape; with: nodeCollection
]

{ #category : #accessing }
GtRoassal >> circle [
	^ (BlElement new 
		geometry: BlEllipseGeometry new;
				border: (BlBorder paint: Color black width: 2);
				size: 50 asPoint)
]

{ #category : #accessing }
GtRoassal >> initialize [
	mondrianInst := super new.
	^ self.
]

{ #category : #accessing }
GtRoassal >> n [
	nodeCollection := (1 to: 10).
]

{ #category : #accessing }
GtRoassal >> nodes [
	nodeCollection := (1 to: 10).
]

{ #category : #accessing }
GtRoassal >> shape [
	nodeShape := BlElement new 
		geometry: BlEllipseGeometry new;
		border: (BlBorder paint: Color black width: 2);
		size: 50 asPoint.
	
]

{ #category : #accessing }
GtRoassal >> stack [
	^ self stack
]
