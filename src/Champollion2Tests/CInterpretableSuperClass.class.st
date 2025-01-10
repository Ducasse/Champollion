Class {
	#name : 'CInterpretableSuperClass',
	#superclass : 'CInterpretableRoot',
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

{ #category : 'lookup' }
CInterpretableSuperClass >> isInSuperclass [
	^ true
]

{ #category : 'lookup' }
CInterpretableSuperClass >> methodInSuperclass [
	^ 5
]

{ #category : 'overridden methods' }
CInterpretableSuperClass >> overriddenMethod [
	^ 5
]

{ #category : 'method lookup' }
CInterpretableSuperClass >> redefinedMethod [
	^ super redefinedMethod
]
