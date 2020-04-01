Extension { #name : #RBTemporaryNode }

{ #category : #'*Champollion' }
RBTemporaryNode >> store: anObject with: anInterpreter [ 
	"storing in a temp just changing the value of the associated binding"
	
	anInterpreter tempAt: name put: anObject
]
