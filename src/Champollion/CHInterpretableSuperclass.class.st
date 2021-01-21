Class {
	#name : #CHInterpretableSuperclass,
	#superclass : #CHInterpretableSecondSuperclass,
	#category : #'Champollion-Tests'
}

{ #category : #testing }
CHInterpretableSuperclass >> isInSuperclass [

	^ true
]

{ #category : #testing }
CHInterpretableSuperclass >> methodInSuperclass [
	^ 5
]

{ #category : #testing }
CHInterpretableSuperclass >> overriddenMethod [
	^ 5
]

{ #category : #testing }
CHInterpretableSuperclass >> redefinedMethodAtThreeLevels [

	^ super redefinedMethodAtThreeLevels
]
