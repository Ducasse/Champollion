Class {
	#name : #CollectingProgramNodeVisitor,
	#superclass : #RBProgramNodeVisitor,
	#category : #Champollion
}

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitAllButLastStatementNodes: aCol [
	"Visit all the statements of a block body except the last one. See visitLastStatementNode:"

	^ aCol do: [ :each | self visitNode: each ]
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitArgumentNode: anArgumentNode [
	"Sent *each time* an argument node is found"
	"does nothing!"
	

]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitArrayNode: anArrayNode [

	^ anArrayNode children collect: [ :each | self visitNode: each ]
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitLastStatementNode: aNode [
	"Visit the last statement of a sequence node (method body or block body)."
	^ self visitNode: aNode
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitLiteralArrayNode: aNode [
		
	^ aNode contents collect: [ :each | self visitNode: each ]
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitMessageArgumentNode: aNode [
	^ self visitNode: aNode
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitMessageArgumentNodes: aCol [

	^ aCol do: [ :each | self visitMessageArgumentNode: each ]
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitMessageNode: aMessageNode [
	(aMessageNode isCascaded not or: [ aMessageNode isFirstCascaded ])
		ifTrue: [ self visitMessageReceiver: aMessageNode receiver ].
	self visitMessageArgumentNodes: aMessageNode arguments
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitMessageReceiver: aNode [
	^ self visitNode: aNode
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitMethodBodyNode: aMethodBodyNode [
	^ self visitNode: aMethodBodyNode 
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitMethodNode: aMethodNode [
	self visitParameterNodes: aMethodNode arguments.
	self visitPragmaNodes: aMethodNode pragmas.
	^ self visitMethodBodyNode: aMethodNode body
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitParameterNode: aNode [
	"We visit a single method parameter, usually a simple variable."
	
	^ self visitNode: aNode
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitParameterNodes: aCol [
	"We visit the **parameter** list of a method: in  foo: anInt, anInt is a parameter and not an argument. 
	We keep the term arguments for the actual objects pass to a message. Basically a list of variables"
	
	^ aCol do: [ :each | self visitParameterNode: each  ]
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitPragmaNode: aPragmaNode [
	^ self visitNode: aPragmaNode
	
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitPragmaNodes: aCol [
	^ aCol do: [ :each | self visitPragmaNode: each ]
	
]

{ #category : #visiting }
CollectingProgramNodeVisitor >> visitSequenceNode: aSequenceNode [
	"Sequence nodes represent method or block body."
	
	self visitTemporaryNodes: aSequenceNode temporaries.
	self visitAllButLastStatementNodes: aSequenceNode statements allButLast.
	^ self visitLastStatementNode: aSequenceNode statements last
]
