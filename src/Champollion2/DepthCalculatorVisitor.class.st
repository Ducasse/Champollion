Class {
	#name : 'DepthCalculatorVisitor',
	#superclass : 'Object',
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'visiting' }
DepthCalculatorVisitor >> visitLiteralValueNode: anASTLiteralValueNode [ 
	 ^ 1
]

{ #category : 'visiting' }
DepthCalculatorVisitor >> visitMessageNode: aMessageNode [ 
	^ 1 + (aMessageNode children
inject: 0
into: [ :max :node | max max: (node acceptVisitor: self) ])
]
