Class {
	#name : 'CInterpreterTest',
	#superclass : 'TestCase',
	#instVars : [
		'interpreter',
		'receiver'
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
	ast := RBParser parseMethod: (CInterpretable >> aSymbol) sourceCode.
	^ self interpreter execute: ast withReceiver: aReceiver
]

{ #category : 'helpers' }
CInterpreterTest >> interpreter [

	^ interpreter
]

{ #category : 'running' }
CInterpreterTest >> setUp [

	super setUp.
	interpreter := CInterpreter new. 
	receiver := CInterpretable new
]

{ #category : 'tests - assignments' }
CInterpreterTest >> testAssignmentReturnsAssignedValue [

	self
		assert: (self executeSelector: #store100IntoInstanceVariableX)
		equals: 100
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

{ #category : 'tests - assignments' }
CInterpreterTest >> testStore100IntoInstanceVariableX [
	
	receiver x: 17.
	self executeSelector: #store100IntoInstanceVariableX.
	self assert: receiver x equals: 100

]
