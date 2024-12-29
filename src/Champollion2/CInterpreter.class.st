Class {
	#name : 'CInterpreter',
	#superclass : 'Object',
	#instVars : [
		'stack',
		'globalScope'
	],
	#category : 'Champollion2-Core',
	#package : 'Champollion2',
	#tag : 'Core'
}

{ #category : 'visiting' }
CInterpreter >> astOf: aCompiledMethod [ 
	^ RBParser parseMethod: aCompiledMethod sourceCode.

]

{ #category : 'private' }
CInterpreter >> currentScope [
	^ self topFrame
]

{ #category : 'execution' }
CInterpreter >> execute: aMethodNode [

	^ self visitNode: aMethodNode
]

{ #category : 'execution' }
CInterpreter >> execute: anAST withReceiver: anObject [

	^ self execute: anAST withReceiver: anObject andArguments: #()
]

{ #category : 'execution' }
CInterpreter >> execute: anAST withReceiver: anObject andArguments: aCollection [
	| result |
	self pushNewMethodFrame.
	self topFrame parentScope: (CInstanceScope new
		receiver: anObject;
		parentScope: globalScope;
		yourself).

	self topFrame receiver: anObject.
	anAST arguments 
		with: aCollection
		do: [ :arg :value | self tempAt: arg name put: value ].
	anAST temporaryNames do: [ :tempName | self tempAt: tempName put: nil ].
	result := self visitNode: anAST.
	self popFrame.
	^ result
]

{ #category : 'accessing' }
CInterpreter >> globalEnvironment [
	^ globalScope
]

{ #category : 'accessing' }
CInterpreter >> globalEnvironmentAt: aSymbol put: anObject [
	globalScope at: aSymbol put: anObject

]

{ #category : 'initialization' }
CInterpreter >> initialize [

	super initialize.
	globalScope := CGlobalScope new.
	stack := CTStack new.
]

{ #category : 'stack frame' }
CInterpreter >> popFrame [
	stack pop
]

{ #category : 'stack frame' }
CInterpreter >> pushNewFrame [
	| newTop |
	newTop := CMethodScope new.
	stack push: newTop.
	^ newTop

]

{ #category : 'stack frame' }
CInterpreter >> pushNewMethodFrame [

	| newTop |
	newTop := CMethodScope new.
	stack push: newTop.
	^ newTop

]

{ #category : 'execution' }
CInterpreter >> receiver [
	^ self topFrame receiver
]

{ #category : 'private' }
CInterpreter >> scopeDefining: aName [
	^ self currentScope scopeDefining: aName

]

{ #category : 'accessing' }
CInterpreter >> tempAt: aSymbol put: anInteger [
	self topFrame at: aSymbol put: anInteger
]

{ #category : 'stack frame' }
CInterpreter >> topFrame [ 
	^ stack top
]

{ #category : 'visiting' }
CInterpreter >> visitAssignmentNode: anAssignmentNode [
	| value | 
	value := self visitNode: anAssignmentNode value.
	(self scopeDefining: anAssignmentNode variable name)
    write: anAssignmentNode variable name
    withValue: value.
	^ value

]

{ #category : 'visiting' }
CInterpreter >> visitLiteralArrayNode: aLiteralArrayNode [

	^ aLiteralArrayNode contents
			collect: [ :literalNode | self visitNode: literalNode ]
			as: Array
]

{ #category : 'visiting' }
CInterpreter >> visitLiteralValueNode: aLiteralValueNode [

	^ aLiteralValueNode value
]

{ #category : 'visiting' }
CInterpreter >> visitMessageNode: aMessageNode [
	| newReceiver method args | 
	newReceiver := self visitNode: aMessageNode receiver.
	args := aMessageNode arguments collect: [ :each | self visitNode: each ].
	method := newReceiver class compiledMethodAt: aMessageNode selector.
	^ self execute: (self astOf: method) withReceiver: newReceiver andArguments: args
	
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

{ #category : 'visiting' }
CInterpreter >> visitVariableNode: aVariableNode [

	^ aVariableNode name = #self | (aVariableNode name = #super)
		  ifTrue: [ self receiver ]
		  ifFalse: [ (self scopeDefining: aVariableNode name) read: aVariableNode name ]
]
