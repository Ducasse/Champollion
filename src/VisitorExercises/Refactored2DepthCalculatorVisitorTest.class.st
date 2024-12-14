Class {
	#name : 'Refactored2DepthCalculatorVisitorTest',
	#superclass : 'TestCase',
	#category : 'VisitorExercises',
	#package : 'VisitorExercises'
}

{ #category : 'tests' }
Refactored2DepthCalculatorVisitorTest >> testDepthMethod [

	| expression |
	expression := Parser parseMethod: 'method
1+1.
self factorial + 2'.
	self
		assert:
		(expression acceptVisitor: Refactored2DepthCalculatorVisitor new)
		equals: 5
]

{ #category : 'tests' }
Refactored2DepthCalculatorVisitorTest >> testDepthOfLiteralSum [

	| expression |
	expression := Parser parseExpression: '1+1'.
	self
		assert: (expression acceptVisitor: RefactoredDepthCalculatorVisitor new)
		equals: 2
]
