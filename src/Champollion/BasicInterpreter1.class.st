Class {
	#name : #BasicInterpreter1,
	#superclass : #Object,
	#instVars : [
		'receiver'
	],
	#category : #'Champollion-Level1'
}

{ #category : #running }
BasicInterpreter1 >> execute: anAST [

	^ self visitNode: anAST
]

{ #category : #running }
BasicInterpreter1 >> execute: anAST with: anObject [

	receiver := anObject.
	^ self visitNode: anAST
]

{ #category : #visiting }
BasicInterpreter1 >> visitAssignmentNode: anAssignmentNode [
	"| x y |
	x := y := 10.
	x
	>>> 10"

	self visitNode: anAssignmentNode variable.
	^ self visitNode: anAssignmentNode value
]

{ #category : #visiting }
BasicInterpreter1 >> visitInstanceVariableNode: aVariableNode [

	^ receiver instVarNamed: aVariableNode name
]

{ #category : #visiting }
BasicInterpreter1 >> visitLiteralValueNode: aRBLiteralValueNode [

	^ aRBLiteralValueNode value
]

{ #category : #visiting }
BasicInterpreter1 >> visitMethodBodyNode: aMethodBodyNode [
	^ self visitNode: aMethodBodyNode 
]

{ #category : #visiting }
BasicInterpreter1 >> visitMethodNode: aMethodNode [

	^ self visitMethodBodyNode: aMethodNode body
]

{ #category : #visiting }
BasicInterpreter1 >> visitNode: aNode [
	^ aNode acceptVisitor: self
]

{ #category : #visiting }
BasicInterpreter1 >> visitReturnNode: aReturnNode [

	^ self visitNode: aReturnNode value
]

{ #category : #visiting }
BasicInterpreter1 >> visitSequenceNode: aSequenceNode [
	
	aSequenceNode statements allButLast do: [ :each | self visitNode: each ].
	^ self visitNode: aSequenceNode statements last.
]
