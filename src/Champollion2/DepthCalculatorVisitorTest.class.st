Class {
	#name : 'DepthCalculatorVisitorTest',
	#superclass : 'TestCase',
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'tests' }
DepthCalculatorVisitorTest >> testDepthMethod [

	| expression |
	expression := Parser parseMethod: 'method
1+1.
self factorial + 2'.
	self 
		assert: (expression acceptVisitor: DepthCalculatorVisitor new) 
		equals: 5.
]

{ #category : 'tests' }
DepthCalculatorVisitorTest >> testDepthOfLiteralSum [

	| expression |
	expression := Parser parseExpression: '1+1'.
	self 
		assert: (expression acceptVisitor: DepthCalculatorVisitor new) 
		equals: 2.
]
