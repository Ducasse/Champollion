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

{ #category : 'primitives' }
CInterpretable >> at [ 
	^ #(11 22 33) at: 2
]

{ #category : 'primitives' }
CInterpretable >> atPut [
	| ar |
	ar := #(11 22 33).
	ar at: 2 put: 44.
	^ ar
]

{ #category : 'primitives' }
CInterpretable >> callingFailingPrimitive [
	^ self failingPrimitive
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

{ #category : 'primitives' }
CInterpretable >> failingPrimitive [
	"this primitive should fail because the receiver must be a SmallInteger and this is clearly not the case."
	
	<primitive: 1>
	^ 'failure'
]

{ #category : 'primitives' }
CInterpretable >> greaterOrEqualIsFalse [
	^ 1 >= 5
]

{ #category : 'primitives' }
CInterpretable >> greaterOrEqualIsTrue [
	^ 5 >= 5
]

{ #category : 'primitives' }
CInterpretable >> greaterThanIsFalse [
	^ 1 > 5
]

{ #category : 'primitives' }
CInterpretable >> greaterThanIsTrue [
	^ 5 > 1
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

{ #category : 'primitives' }
CInterpretable >> lessOrEqualIsFalse [
	^ 1 >= 5
]

{ #category : 'primitives' }
CInterpretable >> lessOrEqualIsTrue [
	^ 5 >= 5
]

{ #category : 'primitives' }
CInterpretable >> lessThanIsFalse [
	^ 1 > 5
]

{ #category : 'primitives' }
CInterpretable >> lessThanIsTrue [
	^ 1 < 5
]

{ #category : 'send messages' }
CInterpretable >> messageArg1: arg1 arg2: arg2 arg3: arg3 [

	^ {arg1 . arg2 . arg3}
]

{ #category : 'primitives' }
CInterpretable >> newArray [
	^ Array basicNew: 4
]

{ #category : 'primitives' }
CInterpretable >> newPoint [
	^ Point basicNew
]

{ #category : 'protocol' }
CInterpretable >> overriddenMethod [
	^ super overriddenMethod
]

{ #category : 'protocol' }
CInterpretable >> overriddenMethod2 [
	^ super overriddenMethod2
]

{ #category : 'blocks' }
CInterpretable >> returnBlock [
	^ [ 'a' . 5 ]
]

{ #category : 'blocks' }
CInterpretable >> returnBlockValue [
	^ [ 'a' . 5 ] value
]

{ #category : 'blocks' }
CInterpretable >> returnBlockWithVariableValue [
	^ [ | a b |
		a := 1.
		b := 2.
		a + b ] value
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

{ #category : 'primitives' }
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
