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
CInterpreterTest >> executeSelector: aSymbol withReceiver: aReceiver andArgs: args [
	
	^ self interpreter
		send: aSymbol
		receiver: aReceiver
		lookupFromClass: aReceiver class
		arguments: args
]

{ #category : 'helpers' }
CInterpreterTest >> interpreter [

	^ interpreter
]

{ #category : 'tests - messages' }
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

{ #category : 'tests - messages' }
CInterpreterTest >> testArgumentAccess [

	receiver x: 200.
	collaborator x: 300.

	self executeSelector: #changeCollaboratorWithArgument.

	self assert: receiver x equals: 200.
	self assert: collaborator x equals: 500
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testArrayNew [
	
	| p |
	self interpreter globalEnvironmentAt: #Array put: Array.
	p := (self executeSelector: #newArray).
	self
		assert: p class 
		equals: Array.
	self 
		assert: p size 
		equals: 4
]

{ #category : 'tests - assignments' }
CInterpreterTest >> testAssignmentReturnsAssignedValue [

	self
		assert: (self executeSelector: #store100IntoInstanceVariableX)
		equals: 100
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testAt [

	 self 
		assert: (self executeSelector: #atPut) 
		equals: #(11 44 33)
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testAtForArray [

	self 
		assert: (self executeSelector: #at: withReceiver: #(1  22 333) andArgs: {2} )
		equals: 22
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testAtForString [

	self 
		assert: (self executeSelector: #at: withReceiver: 'Abcdef' andArgs: {2} )
		equals: $b
]

{ #category : 'tests - messages' }
CInterpreterTest >> testBalancingStack [
	self
		assert: (self executeSelector: #setXAndMessage)
		equals: 1000
]

{ #category : 'tests - blocks' }
CInterpreterTest >> testBlockDefinition [

	| bk |
	bk := (self executeSelector: #returnBlock).
	self 
		assert: bk class 
		equals: CBlock.
		
	self 
		assert: bk code class 
		equals: OCBlockNode 
]

{ #category : 'tests - blocks' }
CInterpreterTest >> testBlockValueIsLastStatementValue [
	self assert: (self executeSelector: #returnBlockValue) equals: 5
]

{ #category : 'test - dnu' }
CInterpreterTest >> testDoesNotUnderstandReifiesMessageWithArguments [
	self
		assert: (self executeSelector: #sendMessageNotUnderstood) arguments
		equals: #( 17 27 )
]

{ #category : 'test - dnu' }
CInterpreterTest >> testDoesNotUnderstandReifiesMessageWithSelector [
	self
		assert: (self executeSelector: #sendMessageNotUnderstood) selector
		equals: #messageIDoNotUnderstandWithArg1:withArg2:
]

{ #category : 'tests - messages' }
CInterpreterTest >> testEvaluationOrderOfArguments [
	| argumentEvaluationOrder |
	argumentEvaluationOrder := self executeSelector: #returnEvaluationOrder.
	"I do not get it currentButComputeNext is executed 4 times."
	self
		assert: (argumentEvaluationOrder collect: 
			[ :peano | self peanoToInteger: peano])
	 	equals: #(1 2 3)
]

{ #category : 'tests - messages' }
CInterpreterTest >> testEvaluationOrderOfReceiver [

	self executeSelector: #evaluateReceiver.
	self assert: (self peanoToInteger: receiver evaluationOrder) equals: 0
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testFailingPrimitive [
	self
		assert: (self executeSelector: #callingFailingPrimitive)
		equals: 'failure'
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testGreaterOrEqualsThanIsFalse [
	self deny: (self executeSelector: #greaterOrEqualIsFalse)
	
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testGreaterOrEqualsThanIsTrue [
	self assert: (self executeSelector: #greaterOrEqualIsTrue)
	
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testGreaterThanIsFalse [
	self deny: (self executeSelector: #greaterThanIsFalse)
	
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testGreaterThanIsTrue [
	self assert: (self executeSelector: #greaterThanIsTrue)
	
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testIdenticalIsFalse [

	self executeSelector: #== withReceiver: 1 andArgs: {2}.
	self executeSelector: #== withReceiver: receiver andArgs: { 2 }.
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testIdenticalIsTrue [

	self executeSelector: #== withReceiver: 1 andArgs: {1}.
	self executeSelector: #== withReceiver: receiver andArgs: { receiver }.
]

{ #category : 'tests - messages' }
CInterpreterTest >> testInstanceVariableStoreInMethodActivationDoesNotChangeSender [
	receiver x: 200.
	collaborator x: 300.

	"changeCollaboratorInstanceVariableX will replace collaborator's x but not the receiver's"
	self executeSelector: #changeCollaboratorInstanceVariableX.

	self assert: receiver x equals: 200.
	self assert: collaborator x equals: 100
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testLessOrEqualIsFalse [
	self deny: (self executeSelector: #lessOrEqualIsFalse)
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testLessOrEqualIsTrue [
	self assert: (self executeSelector: #lessOrEqualIsTrue)
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testLessThanIsFalse [
	self deny: (self executeSelector: #lessThanIsFalse)
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testLessThanIsTrue [
	self assert: (self executeSelector: #lessThanIsTrue)
	
]

{ #category : 'tests - lookup' }
CInterpreterTest >> testLookupMessageInSuperclass [

	self assert: (self executeSelector: #sendMessageInSuperclass) equals: 5
]

{ #category : 'tests - lookup' }
CInterpreterTest >> testLookupRedefinedMethod [
	self assert: (self executeSelector: #overriddenMethod) equals: 5
]

{ #category : 'tests - lookup' }
CInterpreterTest >> testLookupRedefinedMethod2 [
	self assert: (self executeSelector: #overriddenMethod2) equals: 5
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
CInterpreterTest >> testNotIdenticalIsTrue [

	self executeSelector: #== withReceiver: 1 andArgs: {2}.
	self executeSelector: #== withReceiver: receiver andArgs: { 2 }.
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testPointNew [
	
	| p |
	self interpreter globalEnvironmentAt: #Point put: Point.
	p := self executeSelector: #newPoint.
	self
		assert: p class 
		equals: Point
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
		withReceiver: receiver) == receiver
]

{ #category : 'tests - messages' }
CInterpreterTest >> testSelfSend [
	receiver x: 100.
	self 
		assert: (self executeSelector: #sendMessageReturnX) 
		equals: 100
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testSize [

	self 
		assert: (self executeSelector: #size withReceiver: 'Abcdef')
		equals: 6.
	self 
		assert: (self executeSelector: #size withReceiver: #(1 22 333))
		equals: 3
]

{ #category : 'tests - primitives' }
CInterpreterTest >> testSmallIntAddPrimitive [
	self
		assert: (self executeSelector: #smallintAdd)
		equals: 6
]

{ #category : 'tests - assignments' }
CInterpreterTest >> testStore100IntoInstanceVariableX [
	
	receiver x: 17.
	self executeSelector: #store100IntoInstanceVariableX.
	self assert: receiver x equals: 100

]

{ #category : 'tests - messages' }
CInterpreterTest >> testUnassignedTempHasNilValue [
	self
		assert: (self executeSelector: #returnUnassignedTemp)
		equals: nil
]

{ #category : 'tests - messages' }
CInterpreterTest >> testWriteTemporaryVariable [
	self
		assert: (self executeSelector: #writeTemporaryVariable)
		equals: 100
]
