Class {
	#name : #CHInterpretable,
	#superclass : #CHInterpretableSuperclass,
	#instVars : [
		'x',
		'collaborator',
		'evaluationOrder',
		'current'
	],
	#category : #'Champollion-Core'
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

{ #category : #accessing }
CHInterpretable >> collaborator [
	^ collaborator
]

{ #category : #accessing }
CHInterpretable >> collaborator: anObject [
	collaborator := anObject
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
CHInterpretable >> readSelfInBlock [
	^ [ self ] value
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
CHInterpretable >> returnToDeadFrame [
	| aBlock |
	aBlock := self buildBlock.
	aBlock value
]

{ #category : #accessing }
CHInterpretable >> returnX [

	^ x := x
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

{ #category : #accessing }
CHInterpretable >> x [
	^ x
]

{ #category : #accessing }
CHInterpretable >> x: anInteger [ 
	
	x := anInteger
]
