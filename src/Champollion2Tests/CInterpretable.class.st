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

{ #category : 'primitives - atput' }
CInterpretable >> at [

	^ #(11 22 33) at: 2
]

{ #category : 'primitives - atput' }
CInterpretable >> atOutSideBounds [

	^ #(11 22 33) at: 66
]

{ #category : 'primitives - atput' }
CInterpretable >> atPut [

	| ar |
	ar := #(11 22 33).
	ar at: 2 put: 44.
	^ ar
]

{ #category : 'primitives - atput' }
CInterpretable >> atSize [

	^ #(11 22 33) size
]

{ #category : 'primitives - atput' }
CInterpretable >> atString [

	^ 'abc' at: 2
]

{ #category : 'primitives' }
CInterpretable >> callingFailingPrimitive [
	^ self failingPrimitive
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

{ #category : 'does not understand' }
CInterpretable >> doesNotUnderstand: aMessage [
	^ aMessage
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

{ #category : 'primitives' }
CInterpretable >> failingPrimitive [
	<primitive: 1>
	^ 'failure'
]

{ #category : 'primitives' }
CInterpretable >> identical [ 

	^ 1 == 1
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

{ #category : 'primitives' }
CInterpretable >> notIdentical [ 

	^ 1 == 2
]

{ #category : 'overridden methods' }
CInterpretable >> overriddenMethod [
	^ super overriddenMethod
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

{ #category : 'lookup' }
CInterpretable >> sendMessageNotUnderstood [
	^ self messageIDoNotUnderstandWithArg1: 17 withArg2: 27
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

{ #category : 'primitives' }
CInterpretable >> smallintAdd [
	^ 1 + 5
]

{ #category : 'primitives' }
CInterpretable >> smallintDivision [
	^ 20 / 5
]

{ #category : 'primitives - magnitude' }
CInterpretable >> smallintGreaterEqualThan [

	^ 5 >= 5
]

{ #category : 'primitives - magnitude' }
CInterpretable >> smallintGreaterEqualThanNot [

	^ 5 >= 6
]

{ #category : 'primitives - magnitude' }
CInterpretable >> smallintGreaterThan [

	^ 1 < 5
]

{ #category : 'primitives - magnitude' }
CInterpretable >> smallintGreaterThanNot [

	^ 1 > 5
]

{ #category : 'primitives - magnitude' }
CInterpretable >> smallintLessOrEqualsThan [

	^ 1 <= 1 
]

{ #category : 'primitives - magnitude' }
CInterpretable >> smallintLessOrEqualsThanNot [

	^ 2 <= 1 
]

{ #category : 'primitives - magnitude' }
CInterpretable >> smallintLessThan [

	^ 1 < 5
]

{ #category : 'primitives - magnitude' }
CInterpretable >> smallintLessThanNot [

	^ 6 < 5
]

{ #category : 'primitives' }
CInterpretable >> smallintMult [
	^ 2 * 5
]

{ #category : 'primitives' }
CInterpretable >> smallintSub [
	^ 1 - 5
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
