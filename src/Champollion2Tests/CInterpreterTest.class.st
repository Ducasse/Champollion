Class {
	#name : 'CInterpreterTest',
	#superclass : 'TestCase',
	#instVars : [
		'interpreter',
		'receiver',
		'collaborator'
	],
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

{ #category : 'helpers' }
CInterpreterTest >> executeSelector: aSymbol [
  ^ self executeSelector: aSymbol withReceiver: receiver

]

{ #category : 'helpers' }
CInterpreterTest >> executeSelector: aSymbol withReceiver: aReceiver [

	^ self interpreter
		send: aSymbol
		receiver: aReceiver
		lookupFromClass: aReceiver class
		arguments: #()
]

{ #category : 'helpers' }
CInterpreterTest >> interpreter [

	^ interpreter
]

{ #category : 'tests - message arguments' }
CInterpreterTest >> peanoToInteger: aPeanoNumber [
	"Helper method to transform a peano number to a normal Pharo integer"
	^ aPeanoNumber
		ifEmpty: [ 0 ]
		ifNotEmpty: [ 1 + (self peanoToInteger: aPeanoNumber first) ]
]

{ #category : 'running' }
CInterpreterTest >> setUp [

	super setUp.
	interpreter := CInterpreter new. 
	receiver := CInterpretable new.
	collaborator := CInterpretable new.
	receiver collaborator: collaborator

]

{ #category : 'tests - utils' }
CInterpreterTest >> testASTHasClass [

	| ast |
	ast := (RBParser parseMethod: (Point>>#degrees) sourceCode).
	ast methodClass: Point. 
	self deny: ast methodClass isNil.
	self assert: ast methodClass equals: Point
]

{ #category : 'tests - message arguments' }
CInterpreterTest >> testArgumentAccess [

	receiver x: 200.
	collaborator x: 300.

	self executeSelector: #changeCollaboratorWithArgument.

	self assert: receiver x equals: 200.
	self assert: collaborator x equals: 500
]

{ #category : 'tests - assignments' }
CInterpreterTest >> testAssignmentReturnsAssignedValue [

	self
		assert: (self executeSelector: #store100IntoInstanceVariableX)
		equals: 100
]

{ #category : 'tests - message send' }
CInterpreterTest >> testBalancingStack [
	"check that the stack is popped on return"
	
	self
		assert: (self executeSelector: #setXAndMessage)
		equals: 1000
]

{ #category : 'tests - lookup' }
CInterpreterTest >> testDoesNotUnderstandReifiesMessageWithArguments [
	self
		assert: (self executeSelector: #sendMessageNotUnderstood) arguments
		equals: #( 17 27 )
]

{ #category : 'tests - lookup' }
CInterpreterTest >> testDoesNotUnderstandReifiesMessageWithSelector [
	self
		assert: (self executeSelector: #sendMessageNotUnderstood) selector
		equals: #messageIDoNotUnderstandWithArg1:withArg2:
]

{ #category : 'tests - message send' }
CInterpreterTest >> testEvaluationOrderOfArguments [

	| argumentEvaluationOrder |
	argumentEvaluationOrder := self executeSelector: #returnEvaluationOrder.
	self
		assert: (argumentEvaluationOrder collect: 
		[ :peano | self peanoToInteger: peano])
	 equals: #(1 2 3)
]

{ #category : 'tests - message send' }
CInterpreterTest >> testEvaluationOrderOfReceiver [
	self executeSelector: #returnEvaluationOrder.
	self assert: (self peanoToInteger: receiver evaluationOrder) equals: 0.
	
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testFailingPrimitive [
	self
		assert: (self executeSelector: #callingFailingPrimitive)
		equals: 'failure'
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testIdentical [
	self assert: (self executeSelector: #identical)
	
]

{ #category : 'tests - message send' }
CInterpreterTest >> testInstanceVariableStoreInMethodActivationDoesNotChangeSender [
	receiver x: 200.
	collaborator x: 300.

	"changeCollaboratorInstanceVariableX will replace collaborator's x but not the receiver's"
	self executeSelector: #changeCollaboratorInstanceVariableX.

	self assert: receiver x equals: 200.
	self assert: collaborator x equals: 100
]

{ #category : 'tests - lookup' }
CInterpreterTest >> testLookupMessageInSuperclass [
	self 
		assert: (self executeSelector: #sendMessageInSuperclass) 
		equals: 5
]

{ #category : 'tests - lookup' }
CInterpreterTest >> testLookupRedefinedMethod [
	self assert: (self executeSelector: #overriddenMethod) equals: 5
]

{ #category : 'tests - lookup' }
CInterpreterTest >> testLookupSuperMessage [
	self assert: (self executeSelector: #doesSuperLookupFromSuperclass)
]

{ #category : 'tests - lookup' }
CInterpreterTest >> testLookupSuperMessageNotInReceiverSuperclass [
	self assert: (self executeSelector: #redefinedMethod) equals: 5
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testNotIdentical [
	self deny: (self executeSelector: #notIdentical)
	
]

{ #category : 'tests' }
CInterpreterTest >> testReturnBoolean [
  
	self deny: (self executeSelector: #returnBoolean)

]

{ #category : 'helpers' }
CInterpreterTest >> testReturnEmptyLiteralArray [

	self
		assert: (self executeSelector: #returnEmptyLiteralArray)
		equals: #()
]

{ #category : 'tests' }
CInterpreterTest >> testReturnFloat [
	self
		assert: (self executeSelector: #returnFloat)
		equals: 3.14
]

{ #category : 'tests - variables' }
CInterpreterTest >> testReturnGlobal [
	| globalObject |
	globalObject := Object new.
	interpreter globalEnvironmentAt: #Global put: globalObject.
	self assert: (self executeSelector: #returnGlobal) equals: globalObject
]

{ #category : 'tests - variables' }
CInterpreterTest >> testReturnInstanceVariableRead [

	receiver x: 100.
	self
		assert: (self executeSelector: #returnInstanceVariableX)
		equals: 100
]

{ #category : 'tests' }
CInterpreterTest >> testReturnInteger [
	self
		assert: (self executeSelector: #returnInteger)
		equals: 5
]

{ #category : 'helpers' }
CInterpreterTest >> testReturnRecursiveLiteralArray [
	self
		assert: (self executeSelector: #returnRecursiveLiteralArray)
		equals: #(true 1 #('ahah'))
]

{ #category : 'tests - variables' }
CInterpreterTest >> testReturnSelf [

	self assert: (self executeSelector: #returnSelf)
          == receiver

]

{ #category : 'tests - variables' }
CInterpreterTest >> testReturnSuper [
 
  receiver := CInterpretable new.
  "Convey our intention of checking identity by using an explicit identity check"
	self assert: (self
      executeSelector: #returnSuper
      withReceiver: receiver)
          == receiver
]

{ #category : 'tests - message send' }
CInterpreterTest >> testSelfSend [

	receiver x: 100.
	self 
		assert: (self executeSelector: #sendMessageReturnX) 
		equals: 100
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testSmallIntAddPrimitive [
	self
		assert: (self executeSelector: #smallintAdd)
		equals: 6
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testSmallIntDivisionPrimitive [
	self
		assert: (self executeSelector: #smallintDivision)
		equals: 4
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testSmallIntMultiplicationPrimitive [
	self
		assert: (self executeSelector: #smallintMult)
		equals: 10
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testSmallIntSubPrimitive [
	self
		assert: (self executeSelector: #smallintSub)
		equals: -4
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testSmallIntegerLessThan [
	self
		assert: (self executeSelector: #smallintLessThan)
	
]

{ #category : 'tests - assignments' }
CInterpreterTest >> testStore100IntoInstanceVariableX [
	
	receiver x: 17.
	self executeSelector: #store100IntoInstanceVariableX.
	self assert: receiver x equals: 100

]

{ #category : 'tests - variables' }
CInterpreterTest >> testUnassignedTempHasNilValue [
	self
		assert: (self executeSelector: #returnUnassignedTemp)
		equals: nil
]

{ #category : 'tests - variables' }
CInterpreterTest >> testWriteTemporaryVariable [
	self
		assert: (self executeSelector: #writeTemporaryVariable)
		equals: 100
]
