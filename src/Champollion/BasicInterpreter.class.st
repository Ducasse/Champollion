"
Only 
	
	constant
	self send 
	iv
	
	method temps 

"
Class {
	#name : #BasicInterpreter,
	#superclass : #Object,
	#instVars : [
		'receiver'
	],
	#category : #'Champollion-Core'
}

{ #category : #running }
BasicInterpreter >> execute: anAST [

	^ self visitNode: anAST
]

{ #category : #running }
BasicInterpreter >> execute: anAST with: anObject [

	receiver := anObject.
	^ self visitNode: anAST
]

{ #category : #visiting }
BasicInterpreter >> visitAssignmentNode: anAssignmentNode [
	"| x y |
	x := y := 10.
	x
	>>> 10"

	self visitNode: anAssignmentNode variable.
	^ self visitNode: anAssignmentNode value
]

{ #category : #visiting }
BasicInterpreter >> visitInstanceVariableNode: aVariableNode [

	^ receiver instVarNamed: aVariableNode name
]

{ #category : #visiting }
BasicInterpreter >> visitLiteralValueNode: aRBLiteralValueNode [

	^ aRBLiteralValueNode value
]

{ #category : #visiting }
BasicInterpreter >> visitMethodBodyNode: aMethodBodyNode [
	^ self visitNode: aMethodBodyNode 
]

{ #category : #visiting }
BasicInterpreter >> visitMethodNode: aMethodNode [

	^ self visitMethodBodyNode: aMethodNode body
]

{ #category : #visiting }
BasicInterpreter >> visitNode: aNode [
	^ aNode acceptVisitor: self
]

{ #category : #visiting }
BasicInterpreter >> visitReturnNode: aReturnNode [

	^ self visitNode: aReturnNode value
]

{ #category : #visiting }
BasicInterpreter >> visitSequenceNode: aSequenceNode [
	
	aSequenceNode statements allButLast do: [ :each | self visitNode: each ].
	^ self visitNode: aSequenceNode statements last.
]
