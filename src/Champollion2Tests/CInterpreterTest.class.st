Class {
	#name : 'CInterpreterTest',
	#superclass : 'TestCase',
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

{ #category : 'helpers' }
CInterpreterTest >> executeSelector: aSymbol [
  ^ self executeSelector: aSymbol withReceiver: nil

]

{ #category : 'helpers' }
CInterpreterTest >> executeSelector: aSymbol withReceiver: aReceiver [
	| ast |
	ast := RBParser parseMethod: (CInterpretable >> aSymbol) sourceCode.
	^ self interpreter execute: ast withReceiver: aReceiver
]

{ #category : 'helpers' }
CInterpreterTest >> interpreter [

	^ CInterpreter new
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
CInterpreterTest >> testReturnInstanceVariableRead [

	| receiver |
	receiver := CInterpretable new.
	receiver x: 100.
	self
		assert: (self executeSelector: #returnInstanceVariableX withReceiver: receiver)
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
	| receiver |
	receiver := Object new.
 	"Convey our intention of checking identity by using an explicit identity check"
	self assert: (self
      executeSelector: #returnSelf
      withReceiver: receiver)
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
