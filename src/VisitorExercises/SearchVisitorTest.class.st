Class {
	#name : 'SearchVisitorTest',
	#superclass : 'TestCase',
	#category : 'VisitorExercises',
	#package : 'VisitorExercises'
}

{ #category : 'tests' }
SearchVisitorTest >> testTokenInMessageArguments [

	| tree visitor |
	tree := Parser parseMethod: 'one 

self ssss: self pharoMsg.
'.
	visitor := SearchVisitor new.
	visitor token: 'pharo'.
	visitor visit: tree.
	self assert: visitor matchedNodeNames first equals: 'pharoMsg'.
	
]

{ #category : 'tests' }
SearchVisitorTest >> testTokenInMessageReceiver [

	| tree visitor |
	tree := Parser parseMethod: 'one 

self pharo2 pharoVar: 11.
'.
	visitor := SearchVisitor new.
	visitor token: 'pharo'.
	visitor visit: tree.
	self assert: visitor matchedNodeNames first equals: 'pharo2'.
	self assert: visitor matchedNodeNames second equals: 'pharoVar:'
]

{ #category : 'tests' }
SearchVisitorTest >> testTokenInMessageSelector [

	| tree visitor |
	tree := Parser parseMethod: 'one 

self pharoVar: 11.
'.
	visitor := SearchVisitor new.
	visitor token: 'pharo'.
	visitor visit: tree.
	self assert: visitor matchedNodeNames first equals: 'pharoVar:'
]

{ #category : 'tests' }
SearchVisitorTest >> testTokenInVariable [

	| tree visitor |
	tree := Parser parseMethod: 'one 

| pharoVar |
pharoVar := 0.
pharoVar := pharoVar + 1.
^ pharoVar'.
	visitor := SearchVisitor new.
	visitor token: 'pharo'.
	visitor visit: tree.
	self assert: visitor matchedNodeNames first equals: 'pharoVar'
]
