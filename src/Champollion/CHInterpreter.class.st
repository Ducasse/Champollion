"
- Point to discuss 
what is the main API (this cannot be execute since execute is for message but )
we do not have a visit: method

but we have visitNode: 
ok 
"
Class {
	#name : #CHInterpreter,
	#superclass : #Object,
	#instVars : [
		'stack',
		'primitives',
		'globalScope'
	],
	#category : #'Champollion-Core'
}

{ #category : #accessing }
CHInterpreter >> argumentAt: anInteger [ 
	
	^ self tempAt: (self currentMethod arguments at: anInteger) name
]

{ #category : #visiting }
CHInterpreter >> classOf: anObject [

	^ anObject class
]

{ #category : #accessing }
CHInterpreter >> currentMethod [

	^ self tempAt: #__method
]

{ #category : #accessing }
CHInterpreter >> currentMethodClass [
	
	^ self currentMethod propertyAt: #definingClass
]

{ #category : #accessing }
CHInterpreter >> currentScope [

	^ self topFrame
]

{ #category : #executing }
CHInterpreter >> execute: anAST withReceiver: anObject [

	^ self execute: anAST withReceiver: anObject andArguments: #()
]

{ #category : #executing }
CHInterpreter >> execute: anAST withReceiver: anObject andArguments: aCollection [
	"Execute a message whose body is anAST, receiver is anObject and arguments are in aCollection."

	| result thisFrame |
	thisFrame := self pushNewFrame.
	thisFrame
		parentScope:
			(self instanceScopeClass new
				receiver: anObject;
				parentScope: globalScope;
				yourself);
		yourself.
	self tempAt: #__method put: anAST.
	self receiver: anObject.
	anAST arguments
		with: aCollection
		do: [ :arg :value | self tempAt: arg name put: value ].
	result := [ self visitNode: anAST ]
		on: CHReturn
		do: [ :return | 
			return homeFrame = thisFrame
				ifTrue: [ return value ]
				ifFalse: [ return pass ] ].	"A return statement was executed"
	self popFrame.
	^ result
]

{ #category : #executing }
CHInterpreter >> executePrimitive: anAST withReceiver: receiver andArguments: arguments [

	| primitiveNumber |
	primitiveNumber := anAST pragmas
		detect: [ :each | each isPrimitive ]
		ifFound: [ :aPragmaPrimitive | aPragmaPrimitive arguments first value ]
		ifNone: [ self error: 'Not a primitive method' ].
		
	^ self perform: (primitives at: primitiveNumber) with: ({ receiver }, arguments)
]

{ #category : #executing }
CHInterpreter >> executePrimitiveMethod: anAST [

	| primitiveNumber |
	primitiveNumber := anAST pragmas
		detect: [ :each | each isPrimitive ]
		ifFound: [ :aPragmaPrimitive | aPragmaPrimitive arguments first value ]
		ifNone: [ self error: 'Not a primitive method' ].
		
	^ self perform: (primitives at: primitiveNumber)
]

{ #category : #primitives }
CHInterpreter >> globalEnvironmentAt: aSymbol put: anObject [ 
	globalScope at: aSymbol put: anObject
]

{ #category : #initialization }
CHInterpreter >> globalScopeClass [
	^ CHGlobalScope
]

{ #category : #frame }
CHInterpreter >> homeFrame [

	| currentLookupFrame |
	currentLookupFrame := self topFrame.
	[ currentLookupFrame hasDefiningContext ]
		whileTrue: [ currentLookupFrame := currentLookupFrame parentScope ].
	^ currentLookupFrame
]

{ #category : #initialization }
CHInterpreter >> initialize [
	super initialize.
	stack := Stack new.
	globalScope := self globalScopeClass new.
	primitives := Dictionary new.
	self initializePrimitiveTable
]

{ #category : #initialization }
CHInterpreter >> initializePrimitiveTable [

	primitives at: 1 	put: #primitiveSmallIntegerAdd.
	primitives at: 2 	put: #primitiveSmallIntegerMinus.
	primitives at: 9 	put: #primitiveSmallIntegerMultiply.
	primitives at: 10 	put: #primitiveSmallIntegerDivide.
		
	primitives at: 3 	put: #primitiveSmallIntegerLessThan.
	primitives at: 4 	put: #primitiveSmallIntegerGreaterThan.
	primitives at: 5 	put: #primitiveSmallIntegerLessOrEqualsThan.
	primitives at: 6 	put: #primitiveSmallIntegerGreaterOrEqualsThan.
	
	primitives at: 7 	put: #primitiveSmallIntegerEqualsThan.
	primitives at: 8 	put: #primitiveSmallIntegerNotEqualsThan.

	primitives at: 110 	put: #primitiveIdentical.
	primitives at: 111 	put: #primitiveNotIdentical.
		
	primitives at: 60 	put: #primitiveAt.
	primitives at: 61 	put: #primitiveAtPut.
	primitives at: 63 	put: #primitiveStringAt.
	primitives at: 64 	put: #primitiveStringAtPut.

	primitives at: 70 	put: #primitiveBasicNew.
	primitives at: 71 	put: #primitiveBasicNewVariable.
		
	primitives at: 201 put: #primitiveBlockValue.
	primitives at: 202 put: #primitiveBlockValueWith.
]

{ #category : #executing }
CHInterpreter >> instanceScopeClass [
	^ CHInstanceScope
]

{ #category : #lookup }
CHInterpreter >> lookup: aSymbol fromClass: aClass [ 

	"Return the AST of a method or nil if none is found"

	"If the class defines a method for the selector, return the AST corresponding to the method"
	(aClass includesSelector: aSymbol)
		ifTrue: [ ^ (RBParser parseMethod: (aClass compiledMethodAt: aSymbol) sourceCode)
							propertyAt: #definingClass put: aClass;
							yourself ].

	"Otherwise lookup recursively in the superclass.
	If we reach the end of the hierarchy return nil"
	^ aClass superclass
		ifNil: [ nil ]
		ifNotNil: [ self lookup: aSymbol fromClass: aClass superclass ]
]

{ #category : #lookup }
CHInterpreter >> lookupContextDefiningTemporary: aName [

	| currentLookupFrame |
	currentLookupFrame := self topFrame.
	[ currentLookupFrame includesKey: aName ]
		whileFalse: [ currentLookupFrame := currentLookupFrame at: #__definingContext ].
	^ currentLookupFrame
]

{ #category : #accessing }
CHInterpreter >> numberOfArguments [
	
	^ self currentMethod numArgs
]

{ #category : #frame }
CHInterpreter >> popFrame [
	stack pop
]

{ #category : #accessing }
CHInterpreter >> primitiveAt [
	
	self receiver class classLayout isVariable
		ifFalse: [ CHPrimitiveFail signal ].
	
	((self argumentAt: 1) isKindOf: SmallInteger)
		ifFalse: [ CHPrimitiveFail signal ].
		
	^ self receiver basicAt: (self argumentAt: 1)
]

{ #category : #primitives }
CHInterpreter >> primitiveBasicNew [
	
	self receiver isClass
		ifFalse: [ CHPrimitiveFail signal ].
	^ self receiver basicNew
]

{ #category : #primitives }
CHInterpreter >> primitiveBasicNewVariable [
	
	self receiver isClass
		ifFalse: [ CHPrimitiveFail signal ].
	
	((self argumentAt: 1) isKindOf: SmallInteger)
		ifFalse: [ CHPrimitiveFail signal ].
	
	^ self receiver basicNew: (self argumentAt: 1)
]

{ #category : #primitives }
CHInterpreter >> primitiveBlockValue [
		
	| theBlock |
	theBlock := self receiver.
	self topFrame parentScope: theBlock definingContext.
	self receiver: theBlock definingContext receiver.
	^ self visitNode: theBlock code body
]

{ #category : #primitives }
CHInterpreter >> primitiveBlockValueWith [
		
	| theBlock |
	theBlock := self receiver.
	self receiver: theBlock definingContext receiver.
	self tempAt: #__definingContext put: theBlock definingContext.
	theBlock code arguments do: [ :e | | argument |
		argument := self tempAt: self currentMethod arguments first name.
		self tempAt: e name put: argument ].
	^ self visitNode: theBlock code body
]

{ #category : #primitives }
CHInterpreter >> primitiveIdentical [
	
	self numberOfArguments < 1
		ifTrue: [ CHPrimitiveFail signal ].
	
	^ self receiver == (self argumentAt: 1)
]

{ #category : #primitives }
CHInterpreter >> primitiveSmallIntegerAdd [
	
	| receiver argument result |
	self numberOfArguments < 1
		ifTrue: [ CHPrimitiveFail signal ].

	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].
	
	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].

	result := receiver + argument.
	result class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].
	^ result
]

{ #category : #primitives }
CHInterpreter >> primitiveSmallIntegerDivide [
	
	| receiver argument result |
	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].
	
	argument := self argumentAt: 1.
	(argument class = SmallInteger
		and: [ argument ~= 0 ])
		ifFalse: [ CHPrimitiveFail signal ].

	result := receiver / argument.
	result class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].
	^ result
]

{ #category : #primitives }
CHInterpreter >> primitiveSmallIntegerLessThan [
	
	| receiver argument result |
	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].
	
	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].

	^ receiver < argument
]

{ #category : #primitives }
CHInterpreter >> primitiveSmallIntegerMinus [
	
	| receiver argument result |
	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].
	
	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].

	result := receiver - argument.
	result class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].
	^ result
]

{ #category : #primitives }
CHInterpreter >> primitiveSmallIntegerMultiply [
	
	| receiver argument result |
	receiver := self receiver.
	receiver class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].
	
	argument := self argumentAt: 1.
	argument class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].

	result := receiver * argument.
	result class = SmallInteger
		ifFalse: [ CHPrimitiveFail signal ].
	^ result
]

{ #category : #accessing }
CHInterpreter >> primitiveStringAt [
	
	self receiver class classLayout isBytes
		ifFalse: [ CHPrimitiveFail signal ].
	
	((self argumentAt: 1) isKindOf: SmallInteger)
		ifFalse: [ CHPrimitiveFail signal ].
	
	^ self receiver at: (self argumentAt: 1)
]

{ #category : #frame }
CHInterpreter >> pushNewFrame [

	| newTop |
	newTop := CHMethodScope new.
	stack push: newTop.
	^ newTop
]

{ #category : #accessing }
CHInterpreter >> receiver [

	^ self topFrame receiver
]

{ #category : #accessing }
CHInterpreter >> receiver: aValue [

	^ self topFrame receiver: aValue
]

{ #category : #accessing }
CHInterpreter >> scopeDefining: aName [
	^ self currentScope scopeDefining: aName
]

{ #category : #lookup }
CHInterpreter >> send: aSelector receiver: newReceiver lookupFromClass: lookupClass arguments: arguments [
	"Lookup a selector from a class, and activate the method.
	Handle does not undertand case and message reification on demand if lookup fails."

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
		^ self send: #doesNotUnderstand: receiver: newReceiver lookupFromClass: lookupClass arguments: { messageReification } ].

	^ self execute: method withReceiver: newReceiver andArguments: arguments
]

{ #category : #accessing }
CHInterpreter >> superclassOf: aClass [
	
	^ aClass superclass
]

{ #category : #accessing }
CHInterpreter >> tempAt: aSymbol [

	^ self topFrame at: aSymbol
]

{ #category : #accessing }
CHInterpreter >> tempAt: aSymbol put: aValue [

	^ self topFrame at: aSymbol put: aValue
]

{ #category : #frame }
CHInterpreter >> topFrame [

	^ stack top
]

{ #category : #visiting }
CHInterpreter >> visitArrayNode: aRBArrayNode [ 
	
	^ aRBArrayNode statements collect: [ :e | self visitNode: e ] as: Array
]

{ #category : #visiting }
CHInterpreter >> visitAssignmentNode: anAssignmentNode [
	| value |
	value := (self visitNode: anAssignmentNode value).
	(self scopeDefining: anAssignmentNode variable name) write: anAssignmentNode variable name withValue: value.
	^ value
]

{ #category : #visiting }
CHInterpreter >> visitBlockNode: aRBBlockNode [

	^ CHBlock new
		  code: aRBBlockNode;
		  definingContext: self topFrame;
		  interpreter: self;
		  yourself
]

{ #category : #visiting }
CHInterpreter >> visitCascadeNode: aRBCascadeNode [ 
	self shouldBeImplemented.
]

{ #category : #visiting }
CHInterpreter >> visitLiteralArrayNode: aRBLiteralArrayNode [ 

	^ aRBLiteralArrayNode contents 
			collect: [ :literalNode | self visitNode: literalNode ]
			as: Array
]

{ #category : #visiting }
CHInterpreter >> visitLiteralValueNode: aRBLiteralValueNode [ 

	^ aRBLiteralValueNode value
]

{ #category : #visiting }
CHInterpreter >> visitMessageNode: aMessageNode [

	| newReceiver args lookupClass |
	newReceiver := self visitNode: aMessageNode receiver.
	args := aMessageNode arguments collect: [ :each | 
		        self visitNode: each ].

	lookupClass := aMessageNode receiver isSuperVariable
		               ifTrue: [ self superclassOf: self currentMethodClass ]
		               ifFalse: [ self classOf: newReceiver ].
	^ self
		send: aMessageNode selector
		receiver: newReceiver
		lookupFromClass: lookupClass
		arguments: args asArray
]

{ #category : #visiting }
CHInterpreter >> visitMethodNode: aMethodNode [ 
	
	[aMethodNode isPrimitive ifTrue: [ 
		"Do not handle primitive failures for now"
		^ self executePrimitiveMethod: aMethodNode ]]
		on: CHPrimitiveFail do: [ :err | 
			"Nothing, just continue with the method body" ].
	
	^ self visitNode: aMethodNode body
]

{ #category : #'main API' }
CHInterpreter >> visitNode: aNode [
	"I'm the main entry to interpreter AST"
	
	^ aNode acceptVisitor: self
]

{ #category : #visiting }
CHInterpreter >> visitReturnNode: aReturnNode [ 

	CHReturn new
		value: (self visitNode: aReturnNode value);
		homeFrame: self homeFrame;
		signal
]

{ #category : #visiting }
CHInterpreter >> visitSelfNode: aRBVariableNode [ 
	
	^ self receiver
]

{ #category : #visiting }
CHInterpreter >> visitSequenceNode: aSequenceNode [ 

	"Initialize all temporaries in nil"
	aSequenceNode temporaries do: [ :e |
		self tempAt: e name put: nil ].

	"Visit all but the last statement without caring about the result"
	aSequenceNode statements allButLast 
		do: [ :each | self visitNode: each ].
  "Return the result of visiting the last statement"
	^ self visitNode: aSequenceNode statements last
]

{ #category : #visiting }
CHInterpreter >> visitSuperNode: aRBVariableNode [ 
	
	^ self receiver
]

{ #category : #visiting }
CHInterpreter >> visitVariableNode: aVariableNode [

	^ (self scopeDefining: aVariableNode name) read: aVariableNode name
]
