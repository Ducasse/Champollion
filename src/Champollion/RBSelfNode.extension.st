Extension { #name : #RBSelfNode }

{ #category : #'*Champollion' }
RBSelfNode >> lookup: aSymbol fromClass: aClass [ 

	^ (aClass includesSelector: aSymbol)
		ifTrue: [ (aClass compiledMethodAt: aSymbol) ast ]
		ifFalse: [ "no lookup for now" nil ]
]
