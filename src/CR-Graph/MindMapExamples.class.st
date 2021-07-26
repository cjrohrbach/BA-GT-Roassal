Class {
	#name : #MindMapExamples,
	#superclass : #Object,
	#category : #'CR-Graph-MindMap'
}

{ #category : #accessing }
MindMapExamples >> simpleMindMapStructure [
<gtExample>
| root s mi |
	root := MindMapNode new
	model: 'Alphabet';
	addChildren: {
		MindMapNode new
			model: 'a';
			addChildrenFromModels: {'a1'. 'a2'. 'a3'. 'a4'}.
		MindMapNode new
			model: 'b';
			addChildrenFromModels: {'b1'. 'b2'. 'b3'. 'b4'}.
		MindMapNode new
			model: 'c';
			addChildrenFromModels: {'c1'. 'c2'. 'c3'. 'c4'}.
	
	};
	isRoot.

s := MindMapStructure new
	setRootNode: root.

	
^s	
"mi := MindMapIterator new
	mindMapStructure: s;
	createOrder."
]
