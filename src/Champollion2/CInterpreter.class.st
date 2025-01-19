Class {
	#name : 'CInterpreter',
	#superclass : 'Object',
	#instVars : [
		'stack',
		'globalScope',
		'primitives'
	],
	#category : 'Champollion2-Core',
	#package : 'Champollion2',
	#tag : 'Core'
}

{ #category : 'execution' }
CInterpreter >> argumentAt: anInteger [
	^ self tempAt: (self currentMethod arguments at: anInteger) name
]

{ #category : 'visiting' }
CInterpreter >> astOf: aCompiledMethod [
	| ast |
	ast := RBParser parseMethod: aCompiledMethod sourceCode.
	ast methodClass: aCompiledMethod methodClass.
	^ ast
]

{ #category : 'visiting' }
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
	self tempAt: #___method put: anAST.
	self topFrame receiver: anObject.
	self manageArgumentsTemps: aCollection of: anAST.
	result := self visitNode: anAST.
	self popFrame.
	^ result
]

{ #category : 'execution' }
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

{ #category : 'visiting' }
CInterpreter >> handleArgumentsOf: aMessageNode [ 

	^ aMessageNode arguments collect: [ :each | self visitNode: each ]
	
]

{ #category : 'initialization' }
CInterpreter >> initialize [
	super initialize. 
	globalScope := CGlobalScope new.
	stack := Stack new.
	primitives := Dictionary new.
	self initializePrimitiveTable.
]

{ #category : 'initialization' }
CInterpreter >> initializePrimitiveTable [
	primitives at: 1 put: #primitiveSmallIntegerAdd

]

{ #category : 'visiting' }
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

{ #category : 'execution' }
CInterpreter >> manageArgumentsTemps: aCollection of: anAST [

	anAST arguments
		with: aCollection
		do: [ :arg :value | self tempAt: arg name put: value ].
	anAST temporaryNames do: [ :tempName |
		self tempAt: tempName put: nil ]
]

{ #category : 'stack frame' }
CInterpreter >> popFrame [
	stack pop
]

{ #category : 'primitives' }
CInterpreter >> primitiveSmallIntegerAdd [

	| receiver argument |
	receiver := self receiver.
	argument := self argumentAt: 1.
	^ receiver + argument
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

{ #category : 'execution' }
CInterpreter >> send: aSelector receiver: newReceiver lookupFromClass: lookupClass arguments: arguments [
	"Lookup a selector from a class, and activate the method."

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

	^ self execute: (self astOf: method) withReceiver: newReceiver andArguments: arguments
	

]

{ #category : 'accessing' }
CInterpreter >> tempAt: aSymbol [
	^ self topFrame at: aSymbol
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

	aMethodNode isPrimitive ifTrue: [ 
		"Do not handle primitive failures for now"
		^ self executePrimitiveMethod: aMethodNode ].
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
