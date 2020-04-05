Extension { #name : #RBMethodNode }

{ #category : #'*Champollion' }
RBMethodNode >> isValueMessage [
	^ self isPrimitive 
		and: [ (201 to: 206) includes: self primitive ]
]
