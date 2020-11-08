Class {
	#name : #CHInterpretableSuperclass,
	#superclass : #CHInterpretableSecondSuperclass,
	#category : #'Champollion-Core'
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
