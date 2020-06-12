Class {
	#name : #CInterpretableSuperclass,
	#superclass : #CInterpretableSecondSuperclass,
	#category : #'Champollion-Core'
}

{ #category : #'as yet unclassified' }
CInterpretableSuperclass >> methodNotInSubclass [

	^ 5
]

{ #category : #'as yet unclassified' }
CInterpretableSuperclass >> redefinedMethod [

	^ 5
]

{ #category : #'as yet unclassified' }
CInterpretableSuperclass >> redefinedMethodAtThreeLevels [

	^ super redefinedMethodAtThreeLevels
]
