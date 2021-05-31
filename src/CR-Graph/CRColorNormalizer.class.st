"
I can be used to normalize colors over a scope
"
Class {
	#name : #CRColorNormalizer,
	#superclass : #CRNormalizer,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRColorNormalizer >> blend: aColor with: aColorValue weight: wt [
	"Answer a new ColorValue which is a weighted blend of the receiver and the
	supplied ColorValue."
	"Simply interpolates in RGB space."

	| rv gv bv invWt av |
	
	invWt := 1-wt.
	rv := ((aColor red * invWt) + ((aColorValue red)*wt)) "rounded".
	gv := ((aColor green  * invWt) + ((aColorValue green)*wt)) "rounded".
	bv := ((aColor blue * invWt) + ((aColorValue blue)*wt)) "rounded".
	av := ((aColor alpha * invWt) + ((aColorValue alpha)*wt)).
	^Color r: rv g: gv b: bv alpha: av
]

{ #category : #accessing }
CRColorNormalizer >> initialize [
	super initialize.
	^self
]

{ #category : #accessing }
CRColorNormalizer >> valueFor: aNode [
"
	I return the color for the given node.
	Therefore I calculate the ratio for the given
	node and then blend the from and the to color.
"
	| nodeValue ratio color |
	nodeValue := key cull: (aNode model).
	
	( (maxValue - minValue) <= 0 ) ifTrue:
		[^to].
	
	ratio := (nodeValue - minValue) / (maxValue - minValue).
	
	
	color := (self blend: from with: to weight: ratio).
	
	^color
]
