"
- constant
	- self send 
	- iv access
	
	- method temps 
	- args 
	
Next feature
	- super send
	- global access	

What happens with return 
	we push on message send and return of message send. 
	but what about return 
	
How to execute primitive. 
"
Class {
	#name : #BasicInterpreter,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'Champollion-Core'
}

{ #category : #temporaries }
BasicInterpreter >> currentFrame [

	^ stack top 
]

{ #category : #running }
BasicInterpreter >> execute: anAST [

	^ self visitNode: anAST
]

{ #category : #running }
BasicInterpreter >> execute: anAST withReceiver: anObject [

	self tempAt: #self put: anObject.
	^ self visitNode: anAST
]

{ #category : #running }
BasicInterpreter >> execute: aMethodAST withReceiver: anObject andArguments: args [

	self tempAt: #self put: anObject.
	aMethodAST arguments with: args do: [ :arg :value | self tempAt: arg name put: value ]. 
	^ self visitNode: aMethodAST
]

{ #category : #'level4 - real messages' }
BasicInterpreter >> initialize [ 
	super initialize. 
	stack := CTStack new.
	stack push: self newFrame.
]

{ #category : #'level3 - visting - dead simple message' }
BasicInterpreter >> lookup: aSymbol fromClass: aClass [ 
	"return the method ast or nil."
	
	^ (aClass includesSelector: aSymbol)
		ifTrue: [ (aClass compiledMethodAt: aSymbol) ast ]
		ifFalse: [
				aClass = ProtoObject 
					ifTrue: [ nil ]
					ifFalse: [ self lookup: aSymbol fromClass: aClass superclass ]]
]

{ #category : #temporaries }
BasicInterpreter >> newFrame [
	"a new scope is an environment, i.e., a dictionary which supports lookup in its parent.
	This is important to manage variable shadowing. A local temp can hide another temp of a parent
	scope in a local scope."
	
	^ CTEnvironment new
]

{ #category : #'level4 - real messages' }
BasicInterpreter >> popFrame [

	stack pop 
	
]

{ #category : #'level4 - real messages' }
BasicInterpreter >> pushNewFrame [
	"Pushing a new scope consists in creating a new dictionary whose parent is the top of the stack
	and pushing it as a new top. This way a variable not found in current scope will be looked up in previous scope."

	| newTop |
	newTop := self newFrame.
	newTop parent: stack top.
	stack push: newTop.
	^ newTop
	
]

{ #category : #accessing }
BasicInterpreter >> receiver [
	^ stack top at: #self
]

{ #category : #accessing }
BasicInterpreter >> stack [
	^ stack
]

{ #category : #temporaries }
BasicInterpreter >> tempAt: aSymbol [

	^ self currentFrame at: aSymbol
]

{ #category : #temporaries }
BasicInterpreter >> tempAt: aSymbol put: anInteger [ 

	self currentFrame at: aSymbol put: anInteger
]

{ #category : #'level4 - real messages' }
BasicInterpreter >> try [

	| tmp |
	tmp := 3.
	[:x | 
		| tmp1 | 
		tmp := 2].
	^ tmp
]

{ #category : #'level4 - real messages' }
BasicInterpreter >> visitArgumentNode: aRBArgumentNode [ 
	^ self tempAt: aRBArgumentNode name
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

{ #category : #'level3 - class message' }
BasicInterpreter >> visitGlobalNode: aRBGlobalNode [ 

	^ self class environment at: aRBGlobalNode name ifAbsent: [ self error: aRBGlobalNode name, ' not found' ]
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter >> visitInstanceVariableNode: aVariableNode [

	^ self receiver instVarNamed: aVariableNode name
]

{ #category : #'level1 - visiting - constant access' }
BasicInterpreter >> visitLiteralValueNode: aRBLiteralValueNode [

	^ aRBLiteralValueNode value
]

{ #category : #'level4 - real messages' }
BasicInterpreter >> visitMessageNode: aMessageNode [

	| rec args method res | 
	self pushNewFrame.
	rec := self visitNode: aMessageNode receiver.
	args := aMessageNode arguments collect: [ :each | self visitNode: each ].
	aMessageNode methodNode isPrimitive
		ifTrue: [
			res := rec tryPrimitive: (aMessageNode methodNode pragmas first argumentAt: 'primitive:') value withArgs: args ]
		ifFalse: [ 	
			method :=  aMessageNode receiver isSuper
				ifTrue: [ self lookup: aMessageNode selector fromClass: rec class superclass ]
				ifFalse: [ self lookup: aMessageNode selector fromClass: rec class ].
			res := self execute: method withReceiver: rec andArguments: args] .
	self popFrame.
	^ res 
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

	^ self visitNode: aReturnNode value.

]

{ #category : #'level3 - visting - dead simple message' }
BasicInterpreter >> visitSelfNode: aRBSelfNode [ 
	^ self receiver
]

{ #category : #'level2 - visiting - temps' }
BasicInterpreter >> visitSequenceNode: aSequenceNode [
	| res |
	aSequenceNode hasTemporaries
		ifTrue: [ self pushNewFrame. 	
				self visitTemporaryNodes: aSequenceNode temporaries].
	aSequenceNode statements allButLast do: [ :each | self visitNode: each ].
	res := self visitNode: aSequenceNode statements last.
	aSequenceNode hasTemporaries
		ifTrue: [ self popFrame ].
	"even if block tmps shared the names with the methods temps, and arguments 
	this frame will have to be popped.
	two block side by side should not share their temp values"
	^ res
]

{ #category : #'as yet unclassified' }
BasicInterpreter >> visitSuperNode: aRBSuperNode [ 
	^ self receiver
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
	
	^ aNodeCollection
		do: [ :each | self visitTemporaryDeclarationNode: each ]
]
