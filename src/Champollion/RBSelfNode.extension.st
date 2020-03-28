Extension { #name : #RBSelfNode }

{ #category : #'*Champollion' }
RBSelfNode >> lookup: aSymbol fromClass: aClass [ 
	"return the method ast or nil."
	
	^ (aClass includesSelector: aSymbol)
		ifTrue: [ (aClass compiledMethodAt: aSymbol) ast ]
		ifFalse: [
				aClass = ProtoObject 
					ifTrue: [ nil ]
					ifFalse: [ self lookup: aSymbol fromClass: aClass superclass ]]
]
