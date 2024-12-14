Class {
	#name : 'DepthCalculatorVisitor',
	#superclass : 'Object',
	#category : 'VisitorExercises',
	#package : 'VisitorExercises'
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

{ #category : 'visiting' }
DepthCalculatorVisitor >> visitMethodNode: aMethodNode [

	^ 1 + (aMethodNode children
		   inject: 0
		   into: [ :max :node | max max: (node acceptVisitor: self) ])
]

{ #category : 'visiting' }
DepthCalculatorVisitor >> visitSequenceNode: aSequenceNode [

	^ 1 + (aSequenceNode children
		   inject: 0
		   into: [ :max :node | max max: (node acceptVisitor: self) ])
]

{ #category : 'visiting' }
DepthCalculatorVisitor >> visitVariableNode: anASTVariableNode [

	^ 1
]
