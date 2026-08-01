Class {
	#name : 'CInterpreter',
	#superclass : 'Object',
	#instVars : [
		'stack',
		'globalScope',
		'primitives'
	],
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'accessing' }
CInterpreter >> argumentAt: anInteger [
	^ self tempAt: (self currentMethod arguments at: anInteger) name
]

{ #category : 'private' }
CInterpreter >> astOf: aCompiledMethod [ 
	| ast |
	ast := OCParser parseMethod: aCompiledMethod sourceCode.
	ast methodClass: aCompiledMethod methodClass.
	^ ast
]

{ #category : 'private' }
CInterpreter >> currentMethod [
	^ self tempAt: #___method
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
	^ self 
		execute: anAST 
		withReceiver: anObject 
		andArguments: #()
]

{ #category : 'execution' }
CInterpreter >> execute: anAST withReceiver: anObject andArguments: aCollection [

	| result |
	self pushNewMethodFrame.
	self tempAt: #___method put: anAST.
	self tempAt: #self put: anObject.
	self flag: #sd. "check self declaration as variables."
	self topFrame parentScope: (CInstanceScope new
			 receiver: anObject;
			 parentScope: globalScope;
			 yourself).
	self topFrame receiver: anObject.
	self manageArgumentsTemps: aCollection of: anAST.
	result := self visitNode: anAST.
	self popFrame.
	^ result
]

{ #category : 'primitives' }
CInterpreter >> executePrimitiveMethod: anAST [
	| primitiveNumber |
	primitiveNumber := anAST pragmas
		detect: [ :each | each isPrimitive ]
		ifFound: [ :aPragmaPrimitive | aPragmaPrimitive arguments first value ]
		ifNone: [ self error: 'Not a primitive method' ].
	^ self perform: (primitives at: primitiveNumber)
]

{ #category : 'accessing' }
CInterpreter >> globalEnvironment [
	^ globalScope
]

{ #category : 'accessing' }
CInterpreter >> globalEnvironmentAt: aSymbol put: anObject [
	globalScope at: aSymbol put: anObject

]

{ #category : 'private' }
CInterpreter >> handleArgumentsOf: aMessageNode [ 
	^ aMessageNode arguments collect: [ :each | self visitNode: each ]
]

{ #category : 'initialization' }
CInterpreter >> initialize [
	
	super initialize. 
	stack := CTStack new.
	globalScope := CGlobalScope new.
	primitives := Dictionary new.
	self initializePrimitiveTable.
]

{ #category : 'initialization' }
CInterpreter >> initializePrimitiveTable [

	primitives at: 1	put: #primitiveSmallIntegerAdd.
	primitives at: 2	put: #primitiveSmallIntegerMinus.
	primitives at: 9	put: #primitiveSmallIntegerMultiply.
	primitives at: 10	put: #primitiveSmallIntegerDivide.
	
	primitives at: 3 	put: #primitiveSmallIntegerLessThan.
	primitives at: 4 	put: #primitiveSmallIntegerGreaterThan.
	primitives at: 5 	put: #primitiveSmallIntegerLessOrEqualsThan.
	primitives at: 6 	put: #primitiveSmallIntegerGreaterOrEqualsThan.
	
	
	primitives at: 7 	put: #primitiveSmallIntegerEqualsThan.
	primitives at: 8 	put: #primitiveSmallIntegerNotEqualsThan.

	primitives at: 60 	put: #primitiveAt.
	primitives at: 61 	put: #primitiveAtPut.
	primitives at: 62 	put: #primitiveSize.
	primitives at: 63 	put: #primitiveStringAt.
	primitives at: 64 	put: #primitiveStringAtPut.
	
	primitives at: 110 	put: #primitiveIdentical.
	primitives at: 111 	put: #primitiveNotIdentical.
	
	primitives at: 70 	put: #primitiveBasicNew.
	primitives at: 71 	put: #primitiveBasicNewVariable.	

]

{ #category : 'lookup' }
CInterpreter >> lookup: aSelector fromClass: aClass [
	"Return a compiled method or nil if none is found"
	
	"If the class defines a method for the selector, returns the method"
	(aClass includesSelector: aSelector)
		ifTrue: [ ^ aClass compiledMethodAt: aSelector ].
	"Otherwise lookup recursively in the superclass.
	If we reach the end of the hierarchy return nil"
	^ aClass superclass
		ifNil: [ nil ]
		ifNotNil: [ self lookup: aSelector fromClass: aClass superclass ]
]

{ #category : 'private' }
CInterpreter >> manageArgumentsTemps: aCollection of: anAST [
	anAST arguments
		with: aCollection
		do: [ :arg :value | self tempAt: arg name put: value ].
	anAST temporaryNames do: [ :tempName |
		self tempAt: tempName put: nil ]
]

{ #category : 'accessing' }
CInterpreter >> numberOfArguments [
	^ self currentMethod numArgs
]

{ #category : 'execution' }
CInterpreter >> popFrame [
	stack pop
]

{ #category : 'primitives' }
CInterpreter >> primitiveAt [
	| argument |
	self numberOfArguments = 1
		ifFalse: [ CPrimitiveFailed signal ].

	self receiver class classLayout isVariable
		ifFalse: [ CPrimitiveFailed signal ].

	argument := self argumentAt: 1.
	(argument isKindOf: SmallInteger)
		ifFalse: [ CPrimitiveFailed signal ].
		
	"Bounds check"
	(argument between: 1 and: self receiver size)
		ifFalse: [ CPrimitiveFailed signal ].
		
	^ self receiver basicAt: argument
]

{ #category : 'primitives' }
CInterpreter >> primitiveAtPut [
	| argument |
	self numberOfArguments = 2
		ifFalse: [ CPrimitiveFailed signal ].

	self receiver class classLayout isVariable
		ifFalse: [ CPrimitiveFailed signal ].
	argument := self argumentAt: 1.
	(argument isKindOf: SmallInteger)
		ifFalse: [ CPrimitiveFailed signal ].
		
	"Bounds check"
	(argument between: 1 and: self receiver size)
		ifFalse: [ CPrimitiveFailed signal ].
		
	^ self receiver basicAt: argument put: (self argumentAt: 2)
]

{ #category : 'primitives' }
CInterpreter >> primitiveBasicNew [
	self receiver isClass
		ifFalse: [ CPrimitiveFailed signal ].
	^ self receiver basicNew
]

{ #category : 'primitives' }
CInterpreter >> primitiveBasicNewVariable [
	| argument |
	self numberOfArguments = 1
		ifFalse: [ CPrimitiveFailed signal ].

	self receiver isClass
		ifFalse: [ CPrimitiveFailed signal ].
	self receiver classLayout isVariable
		ifFalse: [ CPrimitiveFailed signal ].
	argument := self argumentAt: 1.
	(argument isKindOf: SmallInteger)
		ifFalse: [ CPrimitiveFailed signal ].
	
	^ self receiver basicNew: argument
]

{ #category : 'primitives' }
CInterpreter >> primitiveIdentical [
	self numberOfArguments < 1
		ifTrue: [ CPrimitiveFailed signal ].

	^ self receiver == (self argumentAt: 1)
]

{ #category : 'primitives' }
CInterpreter >> primitiveNotIdentical [
	self numberOfArguments < 1
		ifTrue: [ CPrimitiveFailed signal ].

	^ self receiver ~= (self argumentAt: 1)
]

{ #category : 'primitives' }
CInterpreter >> primitiveSize [
	self receiver class classLayout isVariable
		ifFalse: [ CPrimitiveFailed signal ].
	^ self receiver basicSize
]

{ #category : 'primitives' }
CInterpreter >> primitiveSmallIntegerAdd [
	| receiver argument result |
	self numberOfArguments = 1
		ifFalse: [ CPrimitiveFailed signal ].

	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].

	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].

	result := receiver + argument.
	result class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	^ result
]

{ #category : 'primitives' }
CInterpreter >> primitiveSmallIntegerDivide [
	| receiver argument result |
	self numberOfArguments < 1
		ifTrue: [ CPrimitiveFailed signal ].

	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	
	argument := self argumentAt: 1.
	(argument class = SmallInteger
		and: [ argument ~= 0 ])
			ifFalse: [ CPrimitiveFailed signal ].

	result := receiver / argument.
	result class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	^ result
]

{ #category : 'primitives' }
CInterpreter >> primitiveSmallIntegerGreaterOrEqualsThan [
	| receiver argument |
	self numberOfArguments < 1
		ifTrue: [ CPrimitiveFailed signal ].

	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	
	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].

	^ receiver >= argument
]

{ #category : 'primitives' }
CInterpreter >> primitiveSmallIntegerGreaterThan [
	| receiver argument |
	self numberOfArguments < 1
		ifTrue: [ CPrimitiveFailed signal ].

	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	
	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].

	^ receiver > argument
]

{ #category : 'primitives' }
CInterpreter >> primitiveSmallIntegerLessOrEqualsThan [
	| receiver argument |
	self numberOfArguments < 1
		ifTrue: [ CPrimitiveFailed signal ].

	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	
	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].

	^ receiver <= argument
]

{ #category : 'primitives' }
CInterpreter >> primitiveSmallIntegerLessThan [
	| receiver argument |
	self numberOfArguments < 1
		ifTrue: [ CPrimitiveFailed signal ].

	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	
	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].

	^ receiver < argument
]

{ #category : 'primitives' }
CInterpreter >> primitiveSmallIntegerMinus [
	
	| receiver argument result |
	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	
	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].

	result := receiver - argument.
	result class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	^ result
]

{ #category : 'primitives' }
CInterpreter >> primitiveSmallIntegerMultiply [
	
	| receiver argument result |
	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	
	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].

	result := receiver * argument.
	result class = SmallInteger
		ifFalse: [ CPrimitiveFailed signal ].
	^ result
]

{ #category : 'primitives' }
CInterpreter >> primitiveStringAt [
	| argument |
	self numberOfArguments = 1
		ifFalse: [ CPrimitiveFailed signal ].

	self receiver class classLayout isBytes
		ifFalse: [ CPrimitiveFailed signal ].
	argument := self argumentAt: 1.
	(argument isKindOf: SmallInteger)
		ifFalse: [ CPrimitiveFailed signal ].
	"Bounds check"

	(argument between: 1 and: self receiver size)
		ifFalse: [ CPrimitiveFailed signal ].

	^ self receiver at: argument
]

{ #category : 'execution' }
CInterpreter >> pushNewMethodFrame [
	| newTop |
	newTop := CMethodScope new.
	stack push: newTop.
	^ newTop
]

{ #category : 'accessing' }
CInterpreter >> receiver [
	^ self topFrame receiver
]

{ #category : 'private' }
CInterpreter >> scopeDefining: aName [
	^ self currentScope scopeDefining: aName

]

{ #category : 'execution' }
CInterpreter >> send: aSelector 
	receiver: newReceiver 
	lookupFromClass: lookupClass 
	arguments: arguments [

	| method |
	method := self lookup: aSelector fromClass: lookupClass.
	
	method ifNil: [ | messageReification |
		"Handle does not understand:
		 - lookup the #doesNotUnderstand: selector
		 - reify the message
		 - activate"
		messageReification := Message
			selector: aSelector
			arguments: arguments.
		^ self
			send: #doesNotUnderstand:
			receiver: newReceiver
			lookupFromClass: lookupClass
			arguments: { messageReification } ].
	
	^ self 
		execute: (self astOf: method) 
		withReceiver: newReceiver 
		andArguments: arguments
]

{ #category : 'private' }
CInterpreter >> tempAt: aSymbol [
	^ self topFrame at: aSymbol
]

{ #category : 'accessing' }
CInterpreter >> tempAt: aSymbol put: anInteger [
	self topFrame at: aSymbol put: anInteger
]

{ #category : 'accessing' }
CInterpreter >> topFrame [ 
	^ stack top 
]

{ #category : 'visiting' }
CInterpreter >> visitArrayNode: anArrayNode [
	^ anArrayNode statements 
		collect: [ :e | self visitNode: e ] 
		as: Array
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
CInterpreter >> visitBlockNode: aBlockNode [ 
	^ CBlock new
		code: aBlockNode;
		yourself
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
	| newReceiver args lookupClass | 
	newReceiver := self visitNode: aMessageNode receiver.
	args := self handleArgumentsOf: aMessageNode.
	lookupClass := aMessageNode isSuperSend 
		ifTrue: [ self currentMethod methodClass superclass ] 
		ifFalse: [ newReceiver class ].
	^ self
		send: aMessageNode selector
		receiver: newReceiver
		lookupFromClass: lookupClass
		arguments: args asArray
]

{ #category : 'visiting' }
CInterpreter >> visitMethodNode: aMethodNode [

	[ aMethodNode isPrimitive ifTrue: [ 
		^ self executePrimitiveMethod: aMethodNode ]]
		on: CPrimitiveFailed do: [ :err | 
			"Nothing, just continue with the execution of method body which 
			for primitive is the fallback code." ].
	
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
	
	^ (self scopeDefining: aVariableNode name) read: aVariableNode name
"	^ aVariableNode isSelfVariable | (aVariableNode isSuperVariable)
		ifTrue: [ self receiver ]
		ifFalse: [ (self scopeDefining: aVariableNode name) read: aVariableNode name ]"
]
