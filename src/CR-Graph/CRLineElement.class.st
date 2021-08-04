"
I extend BlLineElement  and am used for edges. 
I extend BlLineElement to predefine the behaviour and look.
"
Class {
	#name : #CRLineElement,
	#superclass : #BlLineElement,
	#traits : 'TCREdge',
	#classTraits : 'TCREdge classTrait',
	#instVars : [
		'group',
		'originalBorder'
	],
	#category : #'CR-Graph-EdgeShape'
}
