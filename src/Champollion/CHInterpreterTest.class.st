Class {
	#name : #CHInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'receiver',
		'collaborator',
		'interpreter'
	],
	#category : #'Champollion-Tests'
}

{ #category : #tests }
CHInterpreterTest >> executeSelector: selector [

	^ self executeSelector: selector withReceiver: receiver
]

{ #category : #tests }
CHInterpreterTest >> executeSelector: selector withReceiver: aReceiver [

	^ self interpreter
		send: selector
		receiver: aReceiver
		lookupFromClass: aReceiver class
		arguments: #()
]

{ #category : #'as yet unclassified' }
CHInterpreterTest >> interpreter [

	^ interpreter
]

{ #category : #tests }
CHInterpreterTest >> peanoToInt: aPeanoNumber [

  ^ aPeanoNumber
   	 ifEmpty: [ 0 ]
    ifNotEmpty: [ 1 + (self peanoToInt: aPeanoNumber first) ]
]

{ #category : #tests }
CHInterpreterTest >> setUp [

	super setUp.
	interpreter := CHInterpreter new.
	
	receiver := CHInterpretable new.
	collaborator := CHInterpretable new.
	receiver collaborator: collaborator
]

{ #category : #tests }
CHInterpreterTest >> testArgumentAccess [

	receiver x: 200.
	collaborator x: 300.

	self executeSelector: #changeCollaboratorWithArgument.

	self assert: receiver x equals: 200.
	self assert: collaborator x equals: 500
]

{ #category : #'3-stack-management' }
CHInterpreterTest >> testArgumentAccessDoesNotEscapeItsDefinition [
	"
	changeCollaboratorXWithConflictingArgumentNAmes
		collaborator collaboratorXIgnoringArgumentWithSameName: 1987
	"

	receiver x: 200.
	collaborator x: 300.

	"Test precondition. Both methods have arguments with the same name.
	Otherwise this test could be green but false."
	self
		assert: (CHInterpretable >> #collaboratorXIgnoringArgumentWithSameName:) argumentNames
		equals: (CHInterpretable >> #x:) argumentNames.
	
	self executeSelector: #changeCollaboratorXWithConflictingArgumentNAmes.

	self assert: receiver x equals: 200.
	self assert: collaborator x equals: 100
]

{ #category : #tests }
CHInterpreterTest >> testArgumentAccessWithSymbol [
	collaborator x: 300.

	self executeSelector: #changeCollaboratorWithArgumentSymbol.

	"
changeCollaboratorWithArgumentSymbol

	collaborator x: #foo
	"
	self assert: collaborator x equals: #foo
]

{ #category : #tests }
CHInterpreterTest >> testAssignmentReturnsAssignedValue [

	self
    assert: (self executeSelector: #store100IntoX)
    equals: 100
]

{ #category : #'3-stack-management' }
CHInterpreterTest >> testBalancingStack [
	"
	setXAndMessage

		x := 1000.
		collaborator returnX.
		^ x
	"

	self assert: (self executeSelector: #setXAndMessage) equals: 1000
]

{ #category : #'chapter three' }
CHInterpreterTest >> testBlock [
	"
	returnBlock
		^ [ 1 . 5 ] 
	"
	| bk1 |
	bk1 := (self executeSelector: #returnBlock).
	self assert: bk1 code isBlock.
	self assert: bk1 code body isSequence
	
]

{ #category : #tests }
CHInterpreterTest >> testBlockTemporaryRead [
	self
    assert: (self executeSelector: #blockTemporary)
    equals: nil
]

{ #category : #tests }
CHInterpreterTest >> testBlockValueIsLastStatementValue [
	self assert: (self executeSelector: #returnBlockValue) equals: 5
]

{ #category : #tests }
CHInterpreterTest >> testDoesNotUnderstandReifiesMessageWithArguments [
	self
    assert: (self executeSelector: #sendMessageNotUnderstood) arguments
    equals: #( 17 27 )
]

{ #category : #tests }
CHInterpreterTest >> testDoesNotUnderstandReifiesMessageWithSelector [

	self
    assert: (self executeSelector: #sendMessageNotUnderstood) selector
    equals: #messageIDoNotUnderstandWithArg1:withArg2:
]

{ #category : #tests }
CHInterpreterTest >> testEvaluationOrder [
  
  | argumentEvaluationOrder |
argumentEvaluationOrder := self executeSelector: #returnEvaluationOrder.

  self assert: (self peanoToInt: receiver evaluationOrder) equals: 0.
  self
    assert: (argumentEvaluationOrder collect: [ :peano | self peanoToInt: peano])
    equals: #(1 2 3)
]

{ #category : #tests }
CHInterpreterTest >> testFailingPrimitive [

	self
      assert: (self executeSelector: #callingFailingPrimitive)
      equals: 'failure'
]

{ #category : #tests }
CHInterpreterTest >> testIncreaseEnclosingTemporary [
	self assert: (self executeSelector: #increaseEnclosingTemporary) equals: 1
]

{ #category : #'2-variables' }
CHInterpreterTest >> testInstanceVariableAccessInMethodActivationDoesNotEscape [
	"
	collaboratorX

		^ collaborator x
	"

	receiver x: 100.
	collaborator x: 200.
	self assert: (self executeSelector: #collaboratorX) equals: 200
]

{ #category : #'2-variables' }
CHInterpreterTest >> testInstanceVariableStoreInMethodActivationDoesNotChangeSender [
	"
	changeCollaboratorX
 		collaborator store100IntoX
	"

	receiver x: 200.
	collaborator x: 300.
	self executeSelector: #changeCollaboratorX.
	self assert: receiver x equals: 200.
	self assert: collaborator x equals: 100
]

{ #category : #tests }
CHInterpreterTest >> testLookupMessageInSuperclass [

	self assert: (self executeSelector: #sendMessageInSuperclass) equals: 5
]

{ #category : #tests }
CHInterpreterTest >> testLookupRedefinedMethod [
	self assert: (self executeSelector: #overriddenMethod) equals: 5
]

{ #category : #tests }
CHInterpreterTest >> testLookupSuperMessage [
	self assert: (self executeSelector: #doesSuperLookupFromSuperclass)
]

{ #category : #'3-stack-management' }
CHInterpreterTest >> testLookupSuperMessageNotInReceiverSuperclass [
	"
	This tests tests that it does not loop\
	
	MiddleSuperclass>>redefinedMethodAtThreeLevels

	^ super redefinedMethodAtThreeLevels

	Superclass>>redefinedMethodAtThreeLevels
		^ 5
	"

	self assert: (self executeSelector: #redefinedMethodAtThreeLevels) equals: 5
]

{ #category : #tests }
CHInterpreterTest >> testNonLocalReturn [

	self assert: (self executeSelector: #methodWithGuard) equals: nil
]

{ #category : #'3-stack-management' }
CHInterpreterTest >> testReadArgumentVariableAfterMessageSend [
	"
	readArgumentVariableAfterMessageSend
		^ self readArgumentVariableAfterMessageSend: 17
	
	readArgumentVariableAfterMessageSend: arg
		collaborator returnUnassignedTemp.
		^ arg
	
	returnUnassignedTemp
		| temp |
		^ temp
	"
	receiver x: 1.
	collaborator x: 2.
	self assert: (self executeSelector: #readArgumentVariableAfterMessageSend) equals: 17
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadBlockTemporaryVariable [
	"
	readBlockTemporaryVariable
		^ [ | temp | temp := 100. temp ] value
	"

	self assert: (self executeSelector: #readBlockTemporaryVariable) equals: 100
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadHomeOuterArgumentVariableInBlock [
	"
	readHomeOuterArgumentVariableInBlock

		^ self readHomeOuterArgumentVariableInBlock: 89
	
	readHomeOuterArgumentVariableInBlock: argument

		^ [ [ argument ] value ] value
	"

	self assert: (self executeSelector: #readHomeOuterArgumentVariableInBlock) equals: 89
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadHomeOuterArgumentVariableInBlockFromDistantCall [
	"
	readHomeOuterArgumentVariableInBlockFromDistantCall

		^ self readHomeOuterArgumentVariableInBlockFromDistantCall: 89
	
	readHomeOuterArgumentVariableInBlockFromDistantCall: argument

		^ self evaluateBlock: [ [ argument ] value ]
	"

	self assert: (self executeSelector: #readHomeOuterArgumentVariableInBlock) equals: 89
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadHomeOuterTemporaryVariableInBlockFromDistantCall [
	"
	readHomeOuterTemporaryVariableInBlockFromDistantCall
		| temp block |
		temp := 1.
		block := [ [ temp ] value ].
		temp := 77.
		^ self evaluateBlock: block
	"

	self assert: (self executeSelector: #readHomeOuterTemporaryVariableInBlockFromDistantCall) equals: 77
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadHomeTemporaryVariableInBlock [
	"
	readHomeTemporaryVariableInBlock
		| temp |
		temp := 17.
		^ [ [ temp ] value ] value
	"

	self assert: (self executeSelector: #readHomeTemporaryVariableInBlock) equals: 17
]

{ #category : #'3-stack-management' }
CHInterpreterTest >> testReadInstanceVariableAfterMessageSend [
	"
	readInstanceVariableAfterMessageSend
		collaborator returnUnassignedTemp.
		^ x
	
	returnUnassignedTemp
		| temp |
		^ temp
	"
	receiver x: 1.
	collaborator x: 2.
	self assert: (self executeSelector: #readInstanceVariableAfterMessageSend) equals: 1
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadInstanceVariableInBlock [
	"
	readInstanceVariableInBlock
		^ [ x ] value
	"

	self assert: (self executeSelector: #readInstanceVariableInBlock) equals: receiver x
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadOuterArgumentVariableInBlock [
	"
	readOuterArgumentVariableInBlock
		^ self readOuterArgumentVariableInBlock: 25

	readOuterArgumentVariableInBlock: argument
		^ [ argument ] value
	"

	self assert: (self executeSelector: #readOuterArgumentVariableInBlock) equals: 25
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadOuterTemporaryVariableInBlock [
	"
	readTemporaryVariableInBlock
		| temp |
		temp := 17.
		^ [ temp ] value
	"

	self assert: (self executeSelector: #readTemporaryVariableInBlock) equals: 17
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadSelfInBlock [
	"
	readSelfInBlock
		^ [ self ] value
	"

	self assert: (self executeSelector: #readSelfInBlock) equals: receiver
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadSuperInBlock [
	"
	readSuperInBlock
		^ [ super ] value
	"

	self assert: (self executeSelector: #readSuperInBlock) equals: receiver
]

{ #category : #'3-stack-management' }
CHInterpreterTest >> testReadTemporaryVariableAfterMessageSend [
	"
	readTemporaryVariableAfterMessageSend
		| temp |
		temp := 17.
		collaborator returnUnassignedTemp.
		^ temp
	
	returnUnassignedTemp
		| temp |
		^ temp
	"
	self assert: (self executeSelector: #readTemporaryVariableAfterMessageSend) equals: 17
]

{ #category : #'3-stack-management' }
CHInterpreterTest >> testReadTemporaryVariableDoesNotEscapeItsDefinition [
	"
	readCollaboratorTemporaryVariable
		| temp |
		temp := 17.
		^ collaborator returnUnassignedTemp
	
	returnUnassignedTemp
		| temp |
		^ temp
	"
	self assert: (self executeSelector: #readCollaboratorTemporaryVariable) equals: nil
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadTwoLevelOuterArgumentVariableInBlock [
	"
	readTwoLevelOuterArgumentVariableInBlock
		^ [ :argument | [ argument ] value ] value: 99
	"

	self assert: (self executeSelector: #readTwoLevelOuterArgumentVariableInBlock) equals: 99
]

{ #category : #'chapter three' }
CHInterpreterTest >> testReadTwoLevelOuterTemporaryVariableInBlock [
	"
	readTwoLevelOuterTemporaryVariableInBlock
		^ [ | temp | temp := 88888. [ temp ] value ] value
	"

	self assert: (self executeSelector: #readTwoLevelOuterTemporaryVariableInBlock) equals: 88888
]

{ #category : #'2-variables' }
CHInterpreterTest >> testReturnAccessInstanceVariable [

	receiver x: 100.
	self assert: (self executeSelector: #returnX) equals: 100
]

{ #category : #tests }
CHInterpreterTest >> testReturnBoolean [

	"Do not use deny: to make explicit that we expect the value false"
	self
    assert: (self executeSelector: #returnBoolean)
    equals: false
]

{ #category : #'1-literals' }
CHInterpreterTest >> testReturnEmptyArray [

	self assert: (self executeSelector: #returnEmptyArray) equals: #() 
]

{ #category : #tests }
CHInterpreterTest >> testReturnEmptyLiteralArray [

	self 
		assert: (self executeSelector: #returnEmptyLiteralArray) 
		equals: #()
]

{ #category : #tests }
CHInterpreterTest >> testReturnFloat [

	| result |
	result := self executeSelector: #returnFloat.
	self assert: result equals: 3.14
]

{ #category : #'2-variables' }
CHInterpreterTest >> testReturnGlobal [

	| globalObject |
	globalObject := Object new.
	interpreter globalEnvironmentAt: #Global put: globalObject. 
	self assert: (self executeSelector: #returnGlobal) equals: globalObject  
]

{ #category : #tests }
CHInterpreterTest >> testReturnInstanceVariableRead [

	| receiver |
	receiver := CHInterpretable new.
	receiver x: 100.
	self
		assert: (self executeSelector: #returnX withReceiver: receiver)
		equals: 100
]

{ #category : #tests }
CHInterpreterTest >> testReturnInteger [
	| result |
	result := self executeSelector: #returnInteger. 
	self assert: result equals: 5
]

{ #category : #tests }
CHInterpreterTest >> testReturnLiteralArray [

	self 
		assert: (self executeSelector: #returnLiteralArray) 
		equals: #(true 1 'ahah')
]

{ #category : #tests }
CHInterpreterTest >> testReturnRecursiveLiteralArray [

	self 
		assert: (self executeSelector: #returnRecursiveLiteralArray) 
		equals: #(true 1 #('ahah'))
]

{ #category : #'2-variables' }
CHInterpreterTest >> testReturnSelf [

	self assert: (self executeSelector: #returnSelf) equals: receiver
]

{ #category : #'2-variables' }
CHInterpreterTest >> testReturnSuper [

	self assert: (self executeSelector: #returnSuper) equals: receiver
]

{ #category : #tests }
CHInterpreterTest >> testSelfSend [

	receiver x: 100.
	self 
		assert: (self executeSelector: #sendMessageReturnX) 
		equals: 100
]

{ #category : #tests }
CHInterpreterTest >> testSmallIntAddPrimitive [

	self
    assert: (self executeSelector: #smallintAdd)
    equals: 6
]

{ #category : #tests }
CHInterpreterTest >> testStore100IntoX [

	receiver x: 17.
	self executeSelector: #store100IntoX.
	self assert: receiver x equals: 100
]

{ #category : #'2-variables' }
CHInterpreterTest >> testStoreInstanceVariable [

	receiver x: 17.
	self executeSelector: #store100IntoX.
	self assert: receiver x equals: 100
]

{ #category : #'3-stack-management' }
CHInterpreterTest >> testUnassignedTempHasNilValue [
	"
	creturnUnassignedTemp
		| temp |
		^ temp
	"

	self assert: (self executeSelector: #returnUnassignedTemp) equals: nil
]

{ #category : #'chapter three' }
CHInterpreterTest >> testWriteInstanceVariableInBlock [
	"
	writeInstanceVariableInBlock
		^ [ x := 17 ] value
	"

	self executeSelector: #writeInstanceVariableInBlock.
	self assert: receiver x equals: 17
]

{ #category : #'3-stack-management' }
CHInterpreterTest >> testWriteTemporaryVariable [
	"writeTemporaryVariable
		| temp |
		temp := 100.
		^ temp
	"
	self assert: (self executeSelector: #writeTemporaryVariable) equals: 100
]

{ #category : #'3-stack-management' }
CHInterpreterTest >> testWriteTemporaryVariableDoesNotEscapeItsDefinition [
	"writeCollaboratorTemporaryVariable

		| temp |
		temp := 17.
		collaborator writeTemporaryVariable.
		^ temp
	
	writeTemporaryVariable

		| temp |
		temp := 100.
		^ temp
	"
	self assert: (self executeSelector: #writeCollaboratorTemporaryVariable) equals: 17
]
