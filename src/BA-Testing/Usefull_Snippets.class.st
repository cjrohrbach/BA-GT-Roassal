Class {
	#name : #'Usefull_Snippets',
	#superclass : #Object,
	#category : #'BA-Testing-BA-Testing'
}

{ #category : #accessing }
Usefull_Snippets >> getAllPackages [
	<gtExample>
	^ RPackageOrganizer default
]
