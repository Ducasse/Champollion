Class {
	#name : 'RefactoredDepthCalculatorVisitor',
	#superclass : 'Object',
	#category : 'VisitorExercises',
	#package : 'VisitorExercises'
}

{ #category : 'common' }
RefactoredDepthCalculatorVisitor >> visitLeafNode: aNode [

	^ 1
]

{ #category : 'visiting' }
RefactoredDepthCalculatorVisitor >> visitLiteralValueNode: aVariableNode [

	^ self visitLeafNode: aVariableNode
]

{ #category : 'visiting' }
RefactoredDepthCalculatorVisitor >> visitMessageNode: aMessageNode [
^ self visitNodeWithChildren: aMessageNode
]

{ #category : 'visiting' }
RefactoredDepthCalculatorVisitor >> visitMethodNode: aMethodNode [

	^ self visitNodeWithChildren: aMethodNode
]

{ #category : 'common' }
RefactoredDepthCalculatorVisitor >> visitNodeWithChildren: aNode [
^ 1 + (aNode children
inject: 0
into: [ :max :node | max max: (node acceptVisitor: self) ])
]

{ #category : 'visiting' }
RefactoredDepthCalculatorVisitor >> visitSequenceNode: aSequenceNode [

	^ self visitNodeWithChildren: aSequenceNode
]

{ #category : 'visiting' }
RefactoredDepthCalculatorVisitor >> visitVariableNode: aVariableNode [

	^ self visitLeafNode: aVariableNode
]
