Class {
	#name : 'Refactored2DepthCalculatorVisitor',
	#superclass : 'Object',
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'visiting' }
Refactored2DepthCalculatorVisitor >> visitLiteralValueNode: aVariableNode [

	^ self visitNode: aVariableNode
]

{ #category : 'visiting' }
Refactored2DepthCalculatorVisitor >> visitMessageNode: aMessageNode [

	^ self visitNode: aMessageNode
]

{ #category : 'visiting' }
Refactored2DepthCalculatorVisitor >> visitMethodNode: aMethodNode [

	^ self visitNode: aMethodNode
]

{ #category : 'visiting' }
Refactored2DepthCalculatorVisitor >> visitNode: aNode [

	^ 1 + (aNode children
		   inject: 0
		   into: [ :max :node | max max: (node acceptVisitor: self) ])
]

{ #category : 'visiting' }
Refactored2DepthCalculatorVisitor >> visitSequenceNode: aSequenceNode [

	^ self visitNode: aSequenceNode
]

{ #category : 'visiting' }
Refactored2DepthCalculatorVisitor >> visitVariableNode: aVariableNode [

	^ self visitNode: aVariableNode
]
