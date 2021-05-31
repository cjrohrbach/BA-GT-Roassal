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
