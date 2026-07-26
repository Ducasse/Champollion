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
	| ast |
	ast := OCParser parseMethod: (CInterpretable >> aSymbol) sourceCode.
	^ self interpreter execute: ast withReceiver: aReceiver
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

{ #category : 'tests - assignments' }
CInterpreterTest >> testAssignmentReturnsAssignedValue [

	self
		assert: (self executeSelector: #store100IntoInstanceVariableX)
		equals: 100
]

{ #category : 'tests - messages' }
CInterpreterTest >> testBalancingStack [
	self
		assert: (self executeSelector: #setXAndMessage)
		equals: 1000
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

{ #category : 'tests - messages' }
CInterpreterTest >> testInstanceVariableStoreInMethodActivationDoesNotChangeSender [
	receiver x: 200.
	collaborator x: 300.

	"changeCollaboratorInstanceVariableX will replace collaborator's x but not the receiver's"
	self executeSelector: #changeCollaboratorInstanceVariableX.

	self assert: receiver x equals: 200.
	self assert: collaborator x equals: 100
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
  | receiver |
  receiver := Object new.
  "Convey our intention of checking identity by using an explicit identity check"
	self assert: (self
      executeSelector: #returnSuper
      withReceiver: receiver)
          == receiver
]

{ #category : 'tests - messages' }
CInterpreterTest >> testSelfSend [
	receiver x: 100.
	self 
		assert: (self executeSelector: #sendMessageReturnX) 
		equals: 100
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
