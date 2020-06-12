Class {
	#name : #CHInterpreter,
	#superclass : #Object,
	#instVars : [
		'stack',
		'globalEnvironment'
	],
	#category : #'Champollion-Core'
}

{ #category : #execute }
CHInterpreter >> execute: anAST withReceiver: anObject [

	self newFrame.
	^ self visitNode: anAST
]

{ #category : #execute }
CHInterpreter >> executeMethod: anAST withReceiver: anObject [
	self pushNewFrame.
	self topFrame at: #self  put: anObject.
	^ self visitNode: anAST
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
CHInterpreter >> topFrame [

	^ stack top 
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
CHInterpreter >> visitMethodBodyNode: aMethodBodyNode [
	^ self visitNode: aMethodBodyNode 
]

{ #category : #visiting }
CHInterpreter >> visitMethodNode: aMethodNode [
	
	^ self visitMethodBodyNode: aMethodNode body
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
