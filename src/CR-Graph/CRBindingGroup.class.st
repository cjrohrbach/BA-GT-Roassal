"
I am a CRGroup with the main difference that  I add myself as group to all elments that are added to me.
Therfore it is important that only objects with a group: method are added to me.
"
Class {
	#name : #CRBindingGroup,
	#superclass : #CRGroup,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRBindingGroup >> addLast: newObject [
"I override the addLast in OrederedCollection to set myself (the group) as the group of the object that is added to me."
	super addLast: newObject.
	newObject group: self.
]
