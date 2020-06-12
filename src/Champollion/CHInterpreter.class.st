Class {
	#name : #CHInterpreter,
	#superclass : #Object,
	#instVars : [
		'stack',
		'globalEnvironment'
	],
	#category : #'Champollion-Core'
}

{ #category : #'stack management' }
CHInterpreter >> currentMethod [
	
	^ self tempAt: #___method
]

{ #category : #execute }
CHInterpreter >> executeMethod: anAST withReceiver: anObject [
	^ self executeMethod: anAST withReceiver: anObject andArguments: #()
]

{ #category : #execute }
CHInterpreter >> executeMethod: anAST withReceiver: anObject andArguments: aCollection [
	
	^ self executeMethod: anAST withReceiver: anObject andArguments: aCollection closureOrNil: nil
]

{ #category : #execute }
CHInterpreter >> executeMethod: anAST withReceiver: anObject andArguments: aCollection closureOrNil: closureOrNil [
	| result |
	self pushNewFrame.
	
	closureOrNil ifNotNil: [ self tempAt: #___closureOrNil put: closureOrNil ].
	self tempAt: #___method put: anAST.
	self tempAt: #self put: anObject.
	anAST arguments with: aCollection do: [ :arg :value | self tempAt: arg name put: value ]. 
	anAST temporaryNames do: [ :tempName | self tempAt: tempName put: nil ]. 
	
	result := self visitNode: anAST body.
	
	self popFrame.
	^ result
]

{ #category : #accessing }
CHInterpreter >> globalEnvironmentAt: aSymbol put: anObject [ 
	globalEnvironment at: aSymbol put: anObject
]

{ #category : #initialization }
CHInterpreter >> initialize [ 
	super initialize. 
	stack := CTStack new.
	globalEnvironment := Dictionary new.

]

{ #category : #'message sends' }
CHInterpreter >> lookup: aSymbol fromClass: aClass [ 
	"Return the AST of a method or nil if none is found"

	"If the class defines a method for the selector, return the AST corresponding to the method"
	(aClass includesSelector: aSymbol)
		ifTrue: [ ^ (aClass compiledMethodAt: aSymbol) ast ].

	"Otherwise lookup recursively in the superclass.
	If we reach the end of the hierarchy return nil"
	^ aClass = ProtoObject 
		ifTrue: [ nil ]
		ifFalse: [ self lookup: aSymbol fromClass: aClass superclass ]
]

{ #category : #'stack management' }
CHInterpreter >> popFrame [
	
	^ stack pop
]

{ #category : #'stack management' }
CHInterpreter >> pushNewFrame [
	"Pushing a new scope consists in creating a new dictionary whose parent is the top of the stack
	and pushing it as a new top. This way a variable not found in current scope will be looked up in previous scope."

	| newTop |
	newTop := Dictionary new.
	stack push: newTop.
	^ newTop
	
]

{ #category : #'stack management' }
CHInterpreter >> receiver [

	^ self topFrame at: #self
]

{ #category : #'stack management' }
CHInterpreter >> tempAt: aSymbol [

	| currentSearchFrame |
	currentSearchFrame := self topFrame.
	[ currentSearchFrame isNil ] whileFalse: [
		currentSearchFrame at: aSymbol ifPresent: [ :found | ^ found ].
		currentSearchFrame := currentSearchFrame
			at: #___closureOrNil
			ifPresent: [ :block | block outerContext ]
			ifAbsent: [ nil ].
	].
	self error: 'Variable ', aSymbol, ' not found'
]

{ #category : #'stack management' }
CHInterpreter >> tempAt: aSymbol put: anInteger [ 

	self topFrame at: aSymbol put: anInteger
]

{ #category : #'stack management' }
CHInterpreter >> topFrame [

	^ stack top 
]

{ #category : #visiting }
CHInterpreter >> visitArgumentNode: aRBArgumentNode [

	^ self tempAt: aRBArgumentNode name
]

{ #category : #visiting }
CHInterpreter >> visitAssignmentNode: anAssignmentNode [
	"| x y |
	x := y := 10.
	x
	>>> 10"
	
	| value | 
	value := (self visitNode: anAssignmentNode value).
	anAssignmentNode variable store: value with: self.
	^ value
]

{ #category : #visiting }
CHInterpreter >> visitBlockNode: aRBBlockNode [ 
	
	^ CHBlock new
		code: aRBBlockNode;
		outerContext: self topFrame;
		yourself
]

{ #category : #visiting }
CHInterpreter >> visitGlobalNode: aRBGlobalNode [ 

	^ globalEnvironment at: aRBGlobalNode name ifAbsent: [ self error: aRBGlobalNode name, ' not found' ]
]

{ #category : #visiting }
CHInterpreter >> visitInstanceVariableNode: aVariableNode [

	^ self receiver instVarNamed: aVariableNode name
]

{ #category : #visiting }
CHInterpreter >> visitLiteralArrayNode: aRBLiteralArrayNode [ 
	
	^ aRBLiteralArrayNode contents collect: [ :each | self visitNode: each ] 
]

{ #category : #visiting }
CHInterpreter >> visitLiteralValueNode: aRBLiteralValueNode [

	^ aRBLiteralValueNode value
]

{ #category : #visiting }
CHInterpreter >> visitMessageNode: aMessageNode [

	| rec method args lookupClass pragma | 
	rec := self visitNode: aMessageNode receiver.
	args := aMessageNode arguments collect: [ :each | self visitNode: each ].
	
	lookupClass := aMessageNode receiver isSuper ifTrue: [ self currentMethod methodClass superclass ] ifFalse: [ rec class ].
	method :=  self lookup: aMessageNode selector fromClass: lookupClass.

	pragma := method pragmaNamed: #astInterpreterPrimitive: ifAbsent: [ nil ].
	pragma ifNotNil: [
		"If the method is marked with the astInterpreterPrimitive: pragma, this is a block evaluation method.
		The receiver is the block closure and the arguments are the arguments of the evaluation"
		^ self
			executeMethod: rec code
			withReceiver: (rec outerContext at: #self)
			andArguments: args
			closureOrNil: rec
	].
	
	^ self executeMethod: method withReceiver: rec andArguments: args
]

{ #category : #visiting }
CHInterpreter >> visitNode: aNode [
	^ aNode acceptVisitor: self
]

{ #category : #visiting }
CHInterpreter >> visitReturnNode: aReturnNode [

	| res |
	res := self visitNode: aReturnNode value.
	^ res
]

{ #category : #visiting }
CHInterpreter >> visitSelfNode: aRBSelfNode [ 
	^ self receiver
]

{ #category : #visiting }
CHInterpreter >> visitSequenceNode: aSequenceNode [
	| res |
	aSequenceNode statements allButLast do: [ :each | self visitNode: each ].
	res := self visitNode: aSequenceNode statements last.
	^ res
]

{ #category : #visiting }
CHInterpreter >> visitSuperNode: aRBSuperNode [ 
	^ self receiver
]

{ #category : #visiting }
CHInterpreter >> visitTemporaryNode: aRBTemporaryNode [ 
	
	^ self tempAt: aRBTemporaryNode name
]
