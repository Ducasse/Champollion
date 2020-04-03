Class {
	#name : #BlockXP,
	#superclass : #Object,
	#category : #'Champollion-ToExperimentWithPharo'
}

{ #category : #accessing }
BlockXP >> escapingMethod1 [

	| a b |
	a := 1. 
	b := self method2: [ ^ a ].
	a := 2.
	^ b
]

{ #category : #accessing }
BlockXP >> method1 [

	| a b |
	a := 1. 
	b := self method2: [ a ].
	a := 2.
	^ b
]

{ #category : #accessing }
BlockXP >> method2: aBlock [

	^ aBlock value
]
