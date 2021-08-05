Metacello new
	baseline: 'BAGTRoassal';
	repository: 'github://cjrohrbach/BA-GT-Roassal/src';
	load: 'core'.

path := '/tmp/result.txt'.
path asFileReference exists ifTrue: [ path asFileReference delete ].
file := path asFileReference writeStream.

b := [ :aName |
	(Smalltalk at: aName) selectors do: [:k | 
		| gotError |
		gotError := false.
		[ (Smalltalk at: aName) new perform: k ] on: Error do: [ :ex | 
			gotError := true. 
			file nextPutAll: ex asString; crlf.
			file nextPutAll: 'Error: '. ].
		gotError ifFalse: [ file nextPutAll: 'Pass: ' ].
		file nextPutAll: aName asString, '>>', k asString; crlf ].
].

b value: #CRMondrianExamples.

file close.

SmalltalkImage current quitPrimitive
