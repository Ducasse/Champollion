Class {
	#name : #CHInterpretable,
	#superclass : #CHInterpretableSuperclass,
	#instVars : [
		'x',
		'collaborator',
		'evaluationOrder',
		'current'
	],
	#category : #'Champollion-Tests'
}

{ #category : #'as yet unclassified' }
CHInterpretable >> bigExample [

	| c |
	c := OrderedCollection new:1.
	c add: 42.
	c add: 17.
	c sort
]

{ #category : #'as yet unclassified' }
CHInterpretable >> blockTemporary [

	^ [ | temp | temp ] value
]

{ #category : #'as yet unclassified' }
CHInterpretable >> buildBlock [
	
	^ [ ^ true ]
]

{ #category : #'as yet unclassified' }
CHInterpretable >> callingFailingPrimitive [

	^ self failingPrimitive
]

{ #category : #'as yet unclassified' }
CHInterpretable >> changeCollaboratorWithArgument [

	collaborator x: 500
]

{ #category : #'as yet unclassified' }
CHInterpretable >> changeCollaboratorWithArgumentSymbol [

	collaborator x: #foo
]

{ #category : #'as yet unclassified' }
CHInterpretable >> changeCollaboratorX [
 		collaborator store100IntoX
]

{ #category : #accessing }
CHInterpretable >> changeCollaboratorXWithConflictingArgumentNAmes [
	self collaboratorXIgnoringArgumentWithSameName: 1987
]

{ #category : #accessing }
CHInterpretable >> collaborator [
	^ collaborator
]

{ #category : #accessing }
CHInterpretable >> collaborator: anObject [
	collaborator := anObject
]

{ #category : #accessing }
CHInterpretable >> collaboratorX [

	^ collaborator x
]

{ #category : #accessing }
CHInterpretable >> collaboratorXIgnoringArgumentWithSameName: anInteger [
	"precondition: The argument of method x: has name anInteger too, and they should not collide"
	collaborator x: 100
]

{ #category : #accessing }
CHInterpretable >> doesNotUnderstand: aMessage [
	^ aMessage
]

{ #category : #'as yet unclassified' }
CHInterpretable >> doesSuperLookupFromSuperclass [
	^ super isInSuperclass
]

{ #category : #'as yet unclassified' }
CHInterpretable >> evaluateBlock: aBlock [

	^ aBlock value
]

{ #category : #'as yet unclassified' }
CHInterpretable >> evaluateReceiver [
  evaluationOrder := self next.
  ^ self
]

{ #category : #accessing }
CHInterpretable >> evaluationOrder [
	^ evaluationOrder
]

{ #category : #'as yet unclassified' }
CHInterpretable >> failingPrimitive [

	<primitive: 1>
	^ 'failure'
]

{ #category : #accessing }
CHInterpretable >> increaseEnclosingTemporary [
	| temp |
	temp := 0.
	[ temp := temp + 1 ] value.
	^ temp
]

{ #category : #'as yet unclassified' }
CHInterpretable >> initialize [
  super initialize.
  current := { "empty" }.
]

{ #category : #testing }
CHInterpretable >> isInSuperclass [

	^ false
]

{ #category : #'as yet unclassified' }
CHInterpretable >> messageArg1: arg1 arg2: arg2 arg3: arg3 [
  ^ {arg1. arg2. arg3}
]

{ #category : #'as yet unclassified' }
CHInterpretable >> methodWithGuard [
  true ifTrue: [ ^ nil ].
  ^ self doSomethingExpensive
]

{ #category : #'as yet unclassified' }
CHInterpretable >> methodWithIfTrueGuard [
  nil = nil ifTrue: [ ^ 42 ].
  ^ self doSomethingExpensive
]

{ #category : #'as yet unclassified' }
CHInterpretable >> methodWithNilGuard [
  nil ifNil: [ ^ 42 ].
  ^ self doSomethingExpensive
]

{ #category : #'as yet unclassified' }
CHInterpretable >> next [
  | next |
  "Implement a stream as an increment in terms of Peano axioms.
  See https://en.wikipedia.org/wiki/Peano_axioms"
  next := current.
  current := { current }.
  ^ next
]

{ #category : #'as yet unclassified' }
CHInterpretable >> overriddenMethod [
	^ super overriddenMethod
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readArgumentVariableAfterMessageSend [
		^ self readArgumentVariableAfterMessageSend: 17
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readArgumentVariableAfterMessageSend: arg [
		collaborator returnUnassignedTemp.
		^ arg
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readBlockTemporaryVariable [
		^ [ | temp | temp := 100. temp ] value
]

{ #category : #accessing }
CHInterpretable >> readCollaboratorTemporaryVariable [
		| temp |
		temp := 17.
		^ collaborator returnUnassignedTemp
	
	
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readHomeOuterArgumentVariableInBlock [

		^ self readHomeOuterArgumentVariableInBlock: 89
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readHomeOuterArgumentVariableInBlock: argument [

		^ [ [ argument ] value ] value
]

{ #category : #accessing }
CHInterpretable >> readHomeOuterArgumentVariableInBlockFromDistantCall [

		^ self readHomeOuterArgumentVariableInBlockFromDistantCall: 89
]

{ #category : #accessing }
CHInterpretable >> readHomeOuterArgumentVariableInBlockFromDistantCall: argument [

		^ self evaluateBlock: [ [ argument ] value ]
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readHomeOuterTemporaryVariableInBlockFromDistantCall [
		| temp block |
		temp := 1.
		block := [ [ temp ] value ].
		temp := 77.
		^ self evaluateBlock: block
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readHomeTemporaryVariableInBlock [
		| temp |
		temp := 17.
		^ [ [ temp ] value ] value
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readInstanceVariableAfterMessageSend [
		collaborator returnUnassignedTemp.
		^ x
	
	
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readInstanceVariableInBlock [
		^ [ x ] value
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readOuterArgumentVariableInBlock [
		^ self readOuterArgumentVariableInBlock: 25
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readOuterArgumentVariableInBlock: argument [
		^ [ argument ] value
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readSelfInBlock [
	^ [ self ] value
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readSuperInBlock [
		^ [ super ] value
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readTemporaryVariableAfterMessageSend [
		| temp |
		temp := 17.
		collaborator returnUnassignedTemp.
		^ temp
	
	
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readTemporaryVariableInBlock [
		| temp |
		temp := 17.
		^ [ temp ] value
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readTwoLevelOuterArgumentVariableInBlock [
		^ [ :argument | [ argument ] value ] value: 99
]

{ #category : #'as yet unclassified' }
CHInterpretable >> readTwoLevelOuterTemporaryVariableInBlock [
		^ [ | temp | temp := 88888. [ temp ] value ] value
]

{ #category : #accessing }
CHInterpretable >> returnBlock [
		^ [ 1 . 5 ] 
]

{ #category : #tests }
CHInterpretable >> returnBlockValue [
	^ [ 1 . 5 ] value
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnBoolean [
	^ false
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnEmptyArray [

	^ #()
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnEmptyLiteralArray [
	^ #()
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnEvaluationOrder [
  ^ self evaluateReceiver
      messageArg1: self next
      arg2: self next
      arg3: self next
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnFloat [

	^ 3.14
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnGlobal [
	^ Global
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnInteger [
	^ 5
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnLiteralArray [
	^ #(true 1 'ahah')
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnRecursiveLiteralArray [
	^ #(true 1 #('ahah'))
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnSelf [
	^ self
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnSuper [

	 ^ super
]

{ #category : #'as yet unclassified' }
CHInterpretable >> returnToDeadFrame [
	| aBlock |
	aBlock := self buildBlock.
	aBlock value
]

{ #category : #accessing }
CHInterpretable >> returnUnassignedTemp [
		| temp |
		^ temp
]

{ #category : #accessing }
CHInterpretable >> returnX [

	^ x
]

{ #category : #'as yet unclassified' }
CHInterpretable >> sendMessageInSuperclass [
	^ self methodInSuperclass
]

{ #category : #accessing }
CHInterpretable >> sendMessageNotUnderstood [
	^ self messageIDoNotUnderstandWithArg1: 17 withArg2: 27
]

{ #category : #'as yet unclassified' }
CHInterpretable >> sendMessageReturnX [

	^ self returnX
]

{ #category : #'as yet unclassified' }
CHInterpretable >> setXAndMessage [

		x := 1000.
		collaborator returnX.
		^ x
]

{ #category : #'as yet unclassified' }
CHInterpretable >> smallintAdd [

	^ 1 + 5
]

{ #category : #'as yet unclassified' }
CHInterpretable >> store100IntoX [

	^ x := 100
]

{ #category : #accessing }
CHInterpretable >> testLookupSuperMessage [
	self assert: (self execute: #doesSuperLookupFromSuperclass)
]

{ #category : #'as yet unclassified' }
CHInterpretable >> toto [
  
self == nil
]

{ #category : #'as yet unclassified' }
CHInterpretable >> writeCollaboratorTemporaryVariable [

		| temp |
		temp := 17.
		collaborator writeTemporaryVariable.
		^ temp
	
	
]

{ #category : #'as yet unclassified' }
CHInterpretable >> writeInstanceVariableInBlock [
		^ [ x := 17 ] value
]

{ #category : #'as yet unclassified' }
CHInterpretable >> writeTemporaryVariable [

		| temp |
		temp := 100.
		^ temp
]

{ #category : #accessing }
CHInterpretable >> x [
	^ x
]

{ #category : #accessing }
CHInterpretable >> x: anInteger [ 
	
	x := anInteger
]
