Class {
	#name : 'RefactoredDepthCalculatorVisitorTest',
	#superclass : 'TestCase',
	#category : 'VisitorExercises',
	#package : 'VisitorExercises'
}

{ #category : 'tests' }
RefactoredDepthCalculatorVisitorTest >> testDepthMethod [

	| expression |
	expression := Parser parseMethod: 'method
1+1.
self factorial + 2'.
	self
		assert: (expression acceptVisitor: RefactoredDepthCalculatorVisitor new)
		equals: 5
]

{ #category : 'tests' }
RefactoredDepthCalculatorVisitorTest >> testDepthOfLiteralSum [

	| expression |
	expression := Parser parseExpression: '1+1'.
	self
		assert: (expression acceptVisitor: RefactoredDepthCalculatorVisitor new)
		equals: 2
]
