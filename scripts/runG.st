Metacello new
	baseline: 'BAGTRoassal';
	repository: 'github://cjrohrbach/BA-GT-Roassal/src';
	load.

path := '/tmp/result.txt'.
path asFileReference exists ifTrue: [ path asFileReference delete ].
file := path asFileReference writeStream.

(Smalltalk at: #CRMondrianExamples) selectors do: [:k | 
	| gotError |
	gotError := false.
	[ (Smalltalk at: #CRMondrianExamples) new perform: k ] on: Error do: [ :ex | 
		gotError := true. 
		file nextPutAll: ex asString; crlf.
		file nextPutAll: 'Error: '. ].
	gotError ifFalse: [ file nextPutAll: 'Pass: ' ].
	file nextPutAll: 'CRMondrianExamples>>', k asString; crlf ].

file close.

SmalltalkImage current quitPrimitive
