Class {
	#name : 'CInterpreter',
	#superclass : 'Object',
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'execution' }
CInterpreter >> execute: aMethodNode [ 
	^ self visitNode: aMethodNode
]

{ #category : 'visiting' }
CInterpreter >> visitLiteralValueNode: aLiteralValueNode [
	^ aLiteralValueNode value
]

{ #category : 'visiting' }
CInterpreter >> visitMethodNode: aMethodNode [
	^ self visitNode: aMethodNode body
]

{ #category : 'visiting' }
CInterpreter >> visitNode: aNode [ 
	^ aNode acceptVisitor: self

]

{ #category : 'visiting' }
CInterpreter >> visitReturnNode: aReturnNode [ 
	^ self visitNode: aReturnNode value

]

{ #category : 'visiting' }
CInterpreter >> visitSequenceNode: aSequenceNode [
	"Visit the sequence and return the result of the last statement. 
	Does not look at temporaris declaration for now."

	aSequenceNode statements allButLast
		do: [ :each | self visitNode: each ].
	^ self visitNode: aSequenceNode statements last

]
