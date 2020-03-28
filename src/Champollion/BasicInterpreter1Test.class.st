Class {
	#name : #BasicInterpreter1Test,
	#superclass : #TestCase,
	#category : #'Champollion-Level1'
}

{ #category : #hooks }
BasicInterpreter1Test >> interpreter [

	^ self interpreterClass new
]

{ #category : #hooks }
BasicInterpreter1Test >> interpreterClass [ 

	^ BasicInterpreter1
]

{ #category : #'level1 - assignment' }
BasicInterpreter1Test >> testAccessXInInstance [

	| ast result |
	ast := (Interpretable >> #returnX) ast.
	result := self interpreter execute: ast with: (Interpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level1 - return constant' }
BasicInterpreter1Test >> testReturnConstant [

	| ast result |
	ast := (Interpretable >> #returnFive) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 5
]

{ #category : #'level1 - return constant' }
BasicInterpreter1Test >> testReturnFalse [

	| ast result |
	ast := (Interpretable >> #returnFalse) ast.
	result := self interpreter execute: ast. 
	self deny: result 
]
