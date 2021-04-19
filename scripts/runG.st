Metacello new
	baseline: 'BAGTRoassal';
	repository: 'github://bergel/BA-GT-Roassal/src';
	load.

path := '/tmp/result.txt'.
path asFileReference exists ifTrue: [ path asFileReference delete ].
file := path asFileReference writeStream.

CRMondrianExamples selectors do: [:k | 
	| gotError |
	gotError := false.
	[ CRMondrianExamples new perform: k ] on: Error do: [ :ex | gotError := true. file nextPutAll: ' ERROR '. ].
	gotError ifFalse: [ file nextPutAll: 'PASS ' ].
	file nextPutAll: 'CRMondrianExamples>>', k asString; crlf ].

file close.

SmalltalkImage current quitPrimitive
