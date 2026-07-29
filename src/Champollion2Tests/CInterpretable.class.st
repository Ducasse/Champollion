Class {
	#name : 'CInterpretable',
	#superclass : 'CInterpretableSuperclass',
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

{ #category : 'send messages' }
CInterpretable >> changeCollaboratorInstanceVariableX [
	collaborator store100IntoInstanceVariableX
]

{ #category : 'send messages' }
CInterpretable >> changeCollaboratorWithArgument [
	collaborator x: 500
]

{ #category : 'accessing' }
CInterpretable >> collaborator [
	^ collaborator
]

{ #category : 'accessing' }
CInterpretable >> collaborator: aCInterpretable [ 
	collaborator := aCInterpretable
]

{ #category : 'send messages' }
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

{ #category : 'dnu' }
CInterpretable >> doesNotUnderstand: aMessage [
	^ aMessage
]

{ #category : 'super' }
CInterpretable >> doesSuperLookupFromSuperclass [
	^ super isInSuperclass
]

{ #category : 'send messages' }
CInterpretable >> evaluateReceiver [

	evaluationOrder := self currentButComputeNextPeanoNumber.
	^ self
]

{ #category : 'send messages' }
CInterpretable >> evaluationOrder [

	^ evaluationOrder
]

{ #category : 'initialization' }
CInterpretable >> initialize [
	super initialize.
	currentPeanoNumber := {}
]

{ #category : 'super' }
CInterpretable >> isInSuperclass [
	^ false
]

{ #category : 'send messages' }
CInterpretable >> messageArg1: arg1 arg2: arg2 arg3: arg3 [

	^ {arg1 . arg2 . arg3}
]

{ #category : 'protocol' }
CInterpretable >> overriddenMethod [
	^ super overriddenMethod
]

{ #category : 'protocol' }
CInterpretable >> overriddenMethod2 [
	^ super overriddenMethod2
]

{ #category : 'returning literals' }
CInterpretable >> returnBoolean [
	^ false

]

{ #category : 'returning literals' }
CInterpretable >> returnEmptyLiteralArray [
	^ #()

]

{ #category : 'send messages' }
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

{ #category : 'send messages' }
CInterpretable >> returnUnassignedTemp [
	| temp |
	^ temp
]

{ #category : 'lookup' }
CInterpretable >> sendMessageInSuperclass [
	^ self methodInSuperclass
]

{ #category : 'dnu' }
CInterpretable >> sendMessageNotUnderstood [
	^ self messageIDoNotUnderstandWithArg1: 17 withArg2: 27
]

{ #category : 'send messages' }
CInterpretable >> sendMessageReturnX [
	^ self returnInstanceVariableX
]

{ #category : 'send messages' }
CInterpretable >> setXAndMessage [
	
	x := 1000.
	collaborator returnInstanceVariableX.
	^ x
]

{ #category : 'accessing' }
CInterpretable >> smallintAdd [
	^ 1 + 5
]

{ #category : 'assignments' }
CInterpretable >> store100IntoInstanceVariableX [

	^ x := 100
]

{ #category : 'send messages' }
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
