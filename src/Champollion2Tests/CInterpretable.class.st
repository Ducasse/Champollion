Class {
	#name : 'CInterpretable',
	#superclass : 'CInterpretableSuperClass',
	#instVars : [
		'x',
		'collaborator',
		'currentPeanoNumber',
		'evaluationOrder'
	],
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

{ #category : 'class initialization' }
CInterpretable class >> initialize [ 
	self setUpGlobal
]

{ #category : 'class initialization' }
CInterpretable class >> setUpGlobal [

	self environment at: #Global put: 33
]

{ #category : 'messages' }
CInterpretable >> changeCollaboratorInstanceVariableX [
	collaborator store100IntoInstanceVariableX
]

{ #category : 'messages' }
CInterpretable >> changeCollaboratorWithArgument [
	collaborator x: 500
]

{ #category : 'accessing' }
CInterpretable >> collaborator [

	^ collaborator
]

{ #category : 'accessing' }
CInterpretable >> collaborator: anObject [

	collaborator := anObject
]

{ #category : 'messages' }
CInterpretable >> currentButComputeNextPeanoNumber [
	| result |
	"Implement a stream as an increment in terms of Peano axioms.
	See https://en.wikipedia.org/wiki/Peano_axioms"
	
	result := currentPeanoNumber.
	"We increment the counter"
	currentPeanoNumber := { currentPeanoNumber }.
	"We return the previous result"
	^ result
]

{ #category : 'lookup' }
CInterpretable >> doesSuperLookupFromSuperclass [
	^ super isInSuperclass
]

{ #category : 'messages' }
CInterpretable >> evaluateReceiver [
	evaluationOrder := self currentButComputeNextPeanoNumber.
	^ self

]

{ #category : 'accessing' }
CInterpretable >> evaluationOrder [ 

	^ evaluationOrder
]

{ #category : 'initialization' }
CInterpretable >> initialize [
	super initialize.
	currentPeanoNumber := { } "Empty"

]

{ #category : 'lookup' }
CInterpretable >> isInSuperclass [
	^ false
]

{ #category : 'messages' }
CInterpretable >> messageArg1: arg1 arg2: arg2 arg3: arg3 [
	^ {arg1 . arg2 . arg3}
]

{ #category : 'returning literals' }
CInterpretable >> returnBoolean [
	^ false

]

{ #category : 'returning literals' }
CInterpretable >> returnEmptyLiteralArray [
	^ #()

]

{ #category : 'messages' }
CInterpretable >> returnEvaluationOrder [
	^ self evaluateReceiver
		messageArg1: self currentButComputeNextPeanoNumber
		arg2: self currentButComputeNextPeanoNumber
		arg3: self currentButComputeNextPeanoNumber
]

{ #category : 'returning literals' }
CInterpretable >> returnFloat [

	^ 3.14
]

{ #category : 'returning variables' }
CInterpretable >> returnGlobal [
	^ Global
]

{ #category : 'returning variables' }
CInterpretable >> returnInstanceVariableX [

	^ x
]

{ #category : 'returning literals' }
CInterpretable >> returnInteger [

	^ 5
]

{ #category : 'returning literals' }
CInterpretable >> returnRecursiveLiteralArray [
	^ #(true 1 #('ahah'))

]

{ #category : 'returning self/super' }
CInterpretable >> returnSelf [

	^ self
]

{ #category : 'returning self/super' }
CInterpretable >> returnSuper [

	^ super
]

{ #category : 'returning variables' }
CInterpretable >> returnUnassignedTemp [
	| temp |
	^ temp
]

{ #category : 'lookup' }
CInterpretable >> sendMessageInSuperclass [
	^ self methodInSuperclass
]

{ #category : 'messages' }
CInterpretable >> sendMessageReturnX [

	^ self returnInstanceVariableX
]

{ #category : 'messages' }
CInterpretable >> setXAndMessage [
		x := 1000.
		collaborator returnInstanceVariableX.
		^ x
]

{ #category : 'assignments' }
CInterpretable >> store100IntoInstanceVariableX [

	^ x := 100
]

{ #category : 'returning variables' }
CInterpretable >> writeTemporaryVariable [
	| temp |
	temp := 100.
	^ temp
]

{ #category : 'accessing' }
CInterpretable >> x [

	^ x
]

{ #category : 'accessing' }
CInterpretable >> x: anObject [

	x := anObject
]
