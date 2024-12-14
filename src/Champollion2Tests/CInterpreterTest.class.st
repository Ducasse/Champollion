Class {
	#name : 'CInterpreterTest',
	#superclass : 'TestCase',
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

{ #category : 'as yet unclassified' }
CInterpreterTest >> executeSelector: aSymbol [
	| ast |
	ast := (CInterpretable >> aSymbol) parseTree.
	^ self interpreter execute: ast

]

{ #category : 'tests' }
CInterpreterTest >> interpreter [

	^ CInterpreter new
]

{ #category : 'tests' }
CInterpreterTest >> testReturnBoolean [
  
	self deny: (self executeSelector: #returnBoolean)

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
