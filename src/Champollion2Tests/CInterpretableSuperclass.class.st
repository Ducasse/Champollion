Class {
	#name : 'CInterpretableSuperclass',
	#superclass : 'CInterpretableRoot',
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

{ #category : 'super' }
CInterpretableSuperclass >> isInSuperclass [
	^ true
]

{ #category : 'testing' }
CInterpretableSuperclass >> methodInSuperclass [
	^ 5
]
