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
		'receiver',
		'frame'
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

{ #category : #'level2 - visiting' }
BasicInterpreter >> newFrame [
	"a new scope is an environment, i.e., a dictionary which supports lookup in its parent.
	This is important to manage variable shadowing. A local temp can hide another temp of a parent
	scope in a local scope."
	
	^ CTEnvironment new
]

{ #category : #accessing }
BasicInterpreter >> receiver [
	^ receiver
]

{ #category : #'level2 - visiting' }
BasicInterpreter >> visitAssignmentNode: anAssignmentNode [
	"| x y |
	x := y := 10.
	x
	>>> 10"
	
	| value | 
	value := (self visitNode: anAssignmentNode value).
	anAssignmentNode variable store: value with: self.
	^ value
]

{ #category : #'level1 - visiting' }
BasicInterpreter >> visitInstanceVariableNode: aVariableNode [

	^ receiver instVarNamed: aVariableNode name
]

{ #category : #'level1 - visiting' }
BasicInterpreter >> visitLiteralValueNode: aRBLiteralValueNode [

	^ aRBLiteralValueNode value
]

{ #category : #'level1 - visiting' }
BasicInterpreter >> visitMethodBodyNode: aMethodBodyNode [
	^ self visitNode: aMethodBodyNode 
]

{ #category : #'level1 - visiting' }
BasicInterpreter >> visitMethodNode: aMethodNode [

	^ self visitMethodBodyNode: aMethodNode body
]

{ #category : #'level1 - visiting' }
BasicInterpreter >> visitNode: aNode [
	^ aNode acceptVisitor: self
]

{ #category : #'level1 - visiting' }
BasicInterpreter >> visitReturnNode: aReturnNode [

	^ self visitNode: aReturnNode value
]

{ #category : #'level2 - visiting' }
BasicInterpreter >> visitSequenceNode: aSequenceNode [
	self visitTemporaryNodes: aSequenceNode temporaries.
	aSequenceNode statements allButLast do: [ :each | self visitNode: each ].
	^ self visitNode: aSequenceNode statements last.
]

{ #category : #'level2 - visiting' }
BasicInterpreter >> visitTemporaryDeclarationNode: aTemporaryDeclarationNode [
	"| temp |
	temp is a temporary node as we can find in the body of methods."

	frame at: aTemporaryDeclarationNode name put: nil.
]

{ #category : #'level2 - visiting' }
BasicInterpreter >> visitTemporaryNode: aTemporaryNode [

	^ frame at: aTemporaryNode name
]

{ #category : #'level2 - visiting' }
BasicInterpreter >> visitTemporaryNodeDeclaration: aNodeCollection [
	"This is triggered when defining the temporaries between the pipes"

	^ aNodeCollection
		do: [ :each | self visitTemporaryDeclarationNode: each ]
]

{ #category : #'level2 - visiting' }
BasicInterpreter >> visitTemporaryNodes: aNodeCollection [
	"This is triggered when defining the temporaries between the pipes"

	^ aNodeCollection
		do: [ :each | self visitTemporaryDeclarationNode: each ]
]
