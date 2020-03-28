Extension { #name : #RBInstanceVariableNode }

{ #category : #'*Champollion' }
RBInstanceVariableNode >> store: anObject with: anInterpreter [ 
	
	anInterpreter receiver instVarNamed: name put: anObject
]
