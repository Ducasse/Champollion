Class {
	#name : 'NodeCollectingSearchVisitor',
	#superclass : 'ASTProgramNodeVisitor',
	#instVars : [
		'token',
		'matchedNodeNames'
	],
	#category : 'VisitorExercises',
	#package : 'VisitorExercises'
}

{ #category : 'initialization' }
NodeCollectingSearchVisitor >> initialize [

	super initialize.
	matchedNodeNames := OrderedCollection new. 
]

{ #category : 'accessing' }
NodeCollectingSearchVisitor >> matchedNodeNames [

	^ matchedNodeNames
]

{ #category : 'accessing' }
NodeCollectingSearchVisitor >> matchedNodeNames: anObject [

	matchedNodeNames := anObject
]

{ #category : 'accessing' }
NodeCollectingSearchVisitor >> token: aToken [

	token := aToken
]

{ #category : 'visiting' }
NodeCollectingSearchVisitor >> visitLiteralValueNode: aNode [

	(aNode value asString beginsWith: token) ifTrue: [
		matchedNodeNames add: aNode value asString ]
]

{ #category : 'visiting' }
NodeCollectingSearchVisitor >> visitMessageNode: aNode [

	aNode receiver acceptVisitor: self.
	(aNode selector beginsWith: token)
			   ifTrue: [ matchedNodeNames add: aNode selector ].
	aNode arguments do: [ :each | each acceptVisitor: self ]
]

{ #category : 'visiting' }
NodeCollectingSearchVisitor >> visitVariableNode: aNode [

	(aNode name beginsWith: token)
		ifTrue: [ matchedNodeNames add: aNode name ]
]
