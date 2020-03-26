Class {
	#name : #BasicInterpreterTest,
	#superclass : #TestCase,
	#category : #Champollion
}

{ #category : #tests }
BasicInterpreterTest >> interpreter [

	^ self interpreterClass new
]

{ #category : #tests }
BasicInterpreterTest >> interpreterClass [ 

	^ BasicInterpreter
]

{ #category : #tests }
BasicInterpreterTest >> testReturnConstant [

	| ast result |
	ast := (Interpretable >> #returnFive) ast.
	self halt.
	
	result := self interpreter execute: ast. 
	self assert: result equals: 5
]
