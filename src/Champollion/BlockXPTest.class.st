Class {
	#name : #BlockXPTest,
	#superclass : #TestCase,
	#category : #'Champollion-ToExperimentWithPharo'
}

{ #category : #tests }
BlockXPTest >> testEscapingReturn [

	self assert: BlockXP new escapingMethod1 equals: 1
]

{ #category : #tests }
BlockXPTest >> testNoReturn [

	self assert: BlockXP new method1 equals: 1
]
