Class {
	#name : 'DepthCalculatorVisitorTest',
	#superclass : 'TestCase',
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'tests' }
DepthCalculatorVisitorTest >> testDepth [

	| expression |
	expression := Parser parseExpression: '1+1'.
	self 
		assert: (expression acceptVisitor: DepthCalculatorVisitor new) 
		equals: 2.
]
