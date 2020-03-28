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

{ #category : #temporaries }
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

{ #category : #temporaries }
BasicInterpreter >> tempAt: aSymbol [

	^ frame at: aSymbol
]

{ #category : #temporaries }
BasicInterpreter >> tempAt: aSymbol put: anInteger [ 

	frame at: aSymbol put: anInteger
]

{ #category : #'level2 - visiting - temps' }
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

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter >> visitInstanceVariableNode: aVariableNode [

	^ receiver instVarNamed: aVariableNode name
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter >> visitLiteralValueNode: aRBLiteralValueNode [

	^ aRBLiteralValueNode value
]

{ #category : #'level3 - visting - message' }
BasicInterpreter >> visitMessageNode: aMessageNode [

	| rec args | 
	rec := self visitNode: aMessageNode receiver.
	args := aMessageNode arguments collect: [ :each | self visitNode: each ].
	
	"
	rec lookup: aMessageNode selector from: 
	"
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter >> visitMethodBodyNode: aMethodBodyNode [
	^ self visitNode: aMethodBodyNode 
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter >> visitMethodNode: aMethodNode [

	^ self visitMethodBodyNode: aMethodNode body
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter >> visitNode: aNode [
	^ aNode acceptVisitor: self
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter >> visitReturnNode: aReturnNode [

	^ self visitNode: aReturnNode value
]

{ #category : #'level2 - visiting - temps' }
BasicInterpreter >> visitSequenceNode: aSequenceNode [

	self visitTemporaryNodes: aSequenceNode temporaries.
	aSequenceNode statements allButLast do: [ :each | self visitNode: each ].
	^ self visitNode: aSequenceNode statements last.
]

{ #category : #'level2 - visiting - temps' }
BasicInterpreter >> visitTemporaryDeclarationNode: aTemporaryDeclarationNode [
	"| temp |
	temp is a temporary node as we can find in the body of methods."

	self tempAt: aTemporaryDeclarationNode name put: nil.
]

{ #category : #'level2 - visiting - temps' }
BasicInterpreter >> visitTemporaryNode: aTemporaryNode [

	^ self tempAt: aTemporaryNode name
]

{ #category : #'level2 - visiting - temps' }
BasicInterpreter >> visitTemporaryNodes: aNodeCollection [
	"This is triggered when defining the temporaries between the pipes"
	
	frame := self newFrame. 	
	^ aNodeCollection
		do: [ :each | self visitTemporaryDeclarationNode: each ]
]
