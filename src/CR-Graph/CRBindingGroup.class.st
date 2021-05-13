Class {
	#name : #CRBindingGroup,
	#superclass : #CRGroup,
	#category : #'CR-Graph-CR-Graph'
}

{ #category : #accessing }
CRBindingGroup >> addLast: newObject [
	super addLast: newObject.
	newObject group: self.
]
