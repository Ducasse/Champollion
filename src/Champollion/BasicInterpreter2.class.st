Class {
	#name : #BasicInterpreter2,
	#superclass : #Object,
	#instVars : [
		'receiver',
		'frame',
		'stack'
	],
	#category : #'Champollion-Level2'
}

{ #category : #running }
BasicInterpreter2 >> execute: anAST [

	^ self visitNode: anAST
]

{ #category : #running }
BasicInterpreter2 >> execute: anAST with: anObject [

	receiver := anObject.
	^ self visitNode: anAST
]

{ #category : #'level3 - visting - dead simple message' }
BasicInterpreter2 >> lookup: aSymbol fromClass: aClass [ 
	"return the method ast or nil."
	
	^ (aClass includesSelector: aSymbol)
		ifTrue: [ (aClass compiledMethodAt: aSymbol) ast ]
		ifFalse: [
				aClass = ProtoObject 
					ifTrue: [ nil ]
					ifFalse: [ self lookup: aSymbol fromClass: aClass superclass ]]
]

{ #category : #temporaries }
BasicInterpreter2 >> newFrame [
	"a new scope is an environment, i.e., a dictionary which supports lookup in its parent.
	This is important to manage variable shadowing. A local temp can hide another temp of a parent
	scope in a local scope."
	
	^ CTEnvironment new
]

{ #category : #accessing }
BasicInterpreter2 >> receiver [
	^ receiver
]

{ #category : #temporaries }
BasicInterpreter2 >> tempAt: aSymbol [

	^ frame at: aSymbol
]

{ #category : #temporaries }
BasicInterpreter2 >> tempAt: aSymbol put: anInteger [ 

	frame at: aSymbol put: anInteger
]

{ #category : #'level2 - visiting - temps' }
BasicInterpreter2 >> visitAssignmentNode: anAssignmentNode [
	"| x y |
	x := y := 10.
	x
	>>> 10"
	
	| value | 
	value := (self visitNode: anAssignmentNode value).
	anAssignmentNode variable store: value with: self.
	^ value
]

{ #category : #'level3 - class message' }
BasicInterpreter2 >> visitGlobalNode: aRBGlobalNode [ 

	^ self class environment at: aRBGlobalNode name ifAbsent: [ self error: aRBGlobalNode name, ' not found' ]
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter2 >> visitInstanceVariableNode: aVariableNode [

	^ receiver instVarNamed: aVariableNode name
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter2 >> visitLiteralValueNode: aRBLiteralValueNode [

	^ aRBLiteralValueNode value
]

{ #category : #'level3 - visting - dead simple message' }
BasicInterpreter2 >> visitMessageNode: aMessageNode [

	| rec method | 
	rec := self visitNode: aMessageNode receiver.
	method := self lookup: aMessageNode selector fromClass: rec class. 
	^ self execute: method
	 
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter2 >> visitMethodBodyNode: aMethodBodyNode [
	^ self visitNode: aMethodBodyNode 
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter2 >> visitMethodNode: aMethodNode [

	^ self visitMethodBodyNode: aMethodNode body
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter2 >> visitNode: aNode [
	^ aNode acceptVisitor: self
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter2 >> visitReturnNode: aReturnNode [

	| val |
	val := self visitNode: aReturnNode value.
	^ val
]

{ #category : #'level3 - visting - dead simple message' }
BasicInterpreter2 >> visitSelfNode: aRBSelfNode [ 
	^ receiver
]

{ #category : #'level2 - visiting - temps' }
BasicInterpreter2 >> visitSequenceNode: aSequenceNode [

	self visitTemporaryNodes: aSequenceNode temporaries.
	aSequenceNode statements allButLast do: [ :each | self visitNode: each ].
	^ self visitNode: aSequenceNode statements last.
]

{ #category : #'level2 - visiting - temps' }
BasicInterpreter2 >> visitTemporaryDeclarationNode: aTemporaryDeclarationNode [
	"| temp |
	temp is a temporary node as we can find in the body of methods."

	self tempAt: aTemporaryDeclarationNode name put: nil.
]

{ #category : #'level2 - visiting - temps' }
BasicInterpreter2 >> visitTemporaryNode: aTemporaryNode [

	^ self tempAt: aTemporaryNode name
]

{ #category : #'level2 - visiting - temps' }
BasicInterpreter2 >> visitTemporaryNodes: aNodeCollection [
	"This is triggered when defining the temporaries between the pipes"
	
	frame := self newFrame. 	
	^ aNodeCollection
		do: [ :each | self visitTemporaryDeclarationNode: each ]
]
