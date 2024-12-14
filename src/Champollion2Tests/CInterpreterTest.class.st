Class {
	#name : 'CInterpreterTest',
	#superclass : 'TestCase',
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

{ #category : 'tests' }
CInterpreterTest >> interpreter [

	^ CInterpreter new
]

{ #category : 'tests' }
CInterpreterTest >> testReturnFloat [

	| ast result |
	ast := (CInterpretable >> #returnFloat) parseTree.
	result := self interpreter execute: ast.
	self assert: result equals: 3.14
]

{ #category : 'tests' }
CInterpreterTest >> testReturnInteger [

	| ast result |
	ast := (CInterpretable >> #returnInteger) parseTree.
	result := self interpreter execute: ast.
	self assert: result equals: 5

]
