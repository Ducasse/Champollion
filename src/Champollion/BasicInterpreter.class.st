"
Only 
	
	constant
	self send 
	iv
"
Class {
	#name : #BasicInterpreter,
	#superclass : #Object,
	#category : #Champollion
}

{ #category : #running }
BasicInterpreter >> execute: anAST [

	^ self visitNode: anAST
]

{ #category : #running }
BasicInterpreter >> visitLiteralValueNode: aRBLiteralValueNode [

	^ aRBLiteralValueNode value
]

{ #category : #running }
BasicInterpreter >> visitMethodBodyNode: aMethodBodyNode [
	^ self visitNode: aMethodBodyNode 
]

{ #category : #running }
BasicInterpreter >> visitMethodNode: aMethodNode [

	^ self visitMethodBodyNode: aMethodNode body
]

{ #category : #running }
BasicInterpreter >> visitNode: aNode [
	^ aNode acceptVisitor: self
]

{ #category : #running }
BasicInterpreter >> visitReturnNode: aReturnNode [

	^ self visitNode: aReturnNode value
]

{ #category : #running }
BasicInterpreter >> visitSequenceNode: aSequenceNode [
	
	aSequenceNode statements do: [ :each | self visitNode: each ]
]
