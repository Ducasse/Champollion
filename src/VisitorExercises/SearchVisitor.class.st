Class {
	#name : 'SearchVisitor',
	#superclass : 'ASTProgramNodeVisitor',
	#instVars : [
		'token',
		'matchedNodeNames'
	],
	#category : 'VisitorExercises',
	#package : 'VisitorExercises'
}

{ #category : 'initialization' }
SearchVisitor >> initialize [

	super initialize.
	matchedNodeNames := OrderedCollection new. 
]

{ #category : 'accessing' }
SearchVisitor >> matchedNodeNames [

	^ matchedNodeNames
]

{ #category : 'accessing' }
SearchVisitor >> matchedNodeNames: anObject [

	matchedNodeNames := anObject
]

{ #category : 'accessing' }
SearchVisitor >> token: aToken [

	token := aToken
]

{ #category : 'visiting' }
SearchVisitor >> visitLiteralValueNode: aNode [

	(aNode value asString beginsWith: token) ifTrue: [
		matchedNodeNames add: aNode value asString ]
]

{ #category : 'visiting' }
SearchVisitor >> visitMessageNode: aNode [

	aNode receiver acceptVisitor: self.
	(aNode selector beginsWith: token)
			   ifTrue: [ matchedNodeNames add: aNode selector ].
	aNode arguments do: [ :each | each acceptVisitor: self ]
]

{ #category : 'visiting' }
SearchVisitor >> visitVariableNode: aNode [

	(aNode name beginsWith: token)
		ifTrue: [ matchedNodeNames add: aNode name ]
]
