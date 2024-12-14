Class {
	#name : 'CInterpreterTest',
	#superclass : 'TestCase',
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

{ #category : 'helpers' }
CInterpreterTest >> executeSelector: aSymbol [
	| ast |
	ast := (CInterpretable >> aSymbol) parseTree.
	^ self interpreter execute: ast

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
