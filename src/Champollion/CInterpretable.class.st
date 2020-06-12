Class {
	#name : #CInterpretable,
	#superclass : #CInterpretableSuperclass,
	#instVars : [
		'x',
		'collaborator'
	],
	#category : #'Champollion-Core'
}

{ #category : #'as yet unclassified' }
CInterpretable class >> return42 [

	^ 42
]

{ #category : #'level4 - message' }
CInterpretable >> addition [

	^ 3 + 2
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> changeCollaboratorWithArgument [

	collaborator x: 500
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> changeCollaboratorX [

	collaborator store100IntoX
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> changeCollaboratorXWithConflictingArgumentNAmes [

	self collaboratorXIgnoringArgumentWithSameName: 1987
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> cocollaboratorX: anInteger [

	self collaboratorX: anInteger

	
]

{ #category : #accessing }
CInterpretable >> collaborator: anObject [

	collaborator := anObject
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> collaboratorX [

	^ collaborator x
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> collaboratorX: anInteger [

	collaborator x: anInteger
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> collaboratorXIgnoringArgumentWithSameName: anInteger [
	"precondition: The argument of method x: has name anInteger too, and they should not collide"
	collaborator x: 100
]

{ #category : #'as yet unclassified' }
CInterpretable >> evaluateBlock: aBlock [

	^ aBlock value
]

{ #category : #'level6 - super basic block' }
CInterpretable >> executingSimpleBlock [

	^ [  5 ] value
]

{ #category : #'level4 - message' }
CInterpretable >> isLiteral [ 
	"isLiteral is defined on the superclass"
	
	^ false isLiteral 
]

{ #category : #'level3 - temporaries' }
CInterpretable >> methodAccessingTemp [

 	| temp |
 	^ temp
]

{ #category : #'level3 - temporaries' }
CInterpretable >> methodCallingModifyingTemp [

 	| temp |
 	temp := 7.
 	self methodModifyingTemp.
	^ temp
]

{ #category : #'level3 - temporaries' }
CInterpretable >> methodModifyingTemp [

 	| temp |
 	temp := 42
]

{ #category : #'level3 - temporaries' }
CInterpretable >> methodWithTemp [

 	| temp |
 	temp := 7.
 	^ self methodAccessingTemp
]

{ #category : #'level4 - message' }
CInterpretable >> not [

	^ false not
]

{ #category : #'level4 - message' }
CInterpretable >> pointCreation [

	^ 10 @ 20
]

{ #category : #'level5 - class messages' }
CInterpretable >> pointCreationViaClass [

	^ Point new
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> readArgumentVariableAfterMessageSend [
	
	^ self readArgumentVariableAfterMessageSend: 17
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> readArgumentVariableAfterMessageSend: arg [

	collaborator returnUnassignedTemp.
	^ arg
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readBlockTemporaryVariable [

	^ [ | temp | temp := 100. temp ] value
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> readCollaboratorTemporaryVariable [

	| temp |
	temp := 17.
	^ collaborator returnUnassignedTemp
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readHomeOuterArgumentVariableInBlock [

	^ self readHomeOuterArgumentVariableInBlock: 89
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readHomeOuterArgumentVariableInBlock: argument [

	^ [ [ argument ] value ] value
]

{ #category : #'as yet unclassified' }
CInterpretable >> readHomeOuterArgumentVariableInBlockFromDistantCall [

	^ self readHomeOuterArgumentVariableInBlockFromDistantCall: 89
]

{ #category : #'as yet unclassified' }
CInterpretable >> readHomeOuterArgumentVariableInBlockFromDistantCall: argument [

	^ self evaluateBlock: [ [ argument ] value ]
]

{ #category : #'as yet unclassified' }
CInterpretable >> readHomeOuterTemporaryVariableInBlockFromDistantCall [

	| temp block |
	temp := 1.
	block := [ [ temp ] value ].
	temp := 77.
	^ true ifTrue: block
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readHomeTemporaryVariableInBlock [
	
	| temp |
	temp := 17.
	^ [ [ temp ] value ] value
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> readInstanceVariableAfterMessageSend [

	collaborator returnUnassignedTemp.
	^ x
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readInstanceVariableInBlock [

	^ [ x ] value
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readOuterArgumentVariableInBlock [

	^ self readOuterArgumentVariableInBlock: 25
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readOuterArgumentVariableInBlock: argument [

	^ [ argument ] value
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readSelfInBlock [

	^ [ self ] value
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readSuperInBlock [

	^ [ super ] value
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> readTemporaryVariable [

	| temp |
	^ temp
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> readTemporaryVariableAfterMessageSend [

	| temp |
	temp := 17.
	collaborator returnUnassignedTemp.
	^ temp
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readTemporaryVariableInBlock [
	
	| temp |
	temp := 17.
	^ [ temp ] value
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readTwoLevelOuterArgumentVariableInBlock [
	
	^ [ :argument | [ argument ] value ] value: 99
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> readTwoLevelOuterTemporaryVariableInBlock [
	
	^ [ | temp | temp := 88888. [ temp ] value ] value
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> redefinedMethod [

	^ super redefinedMethod
]

{ #category : #'level5 - class messages' }
CInterpretable >> return42 [

	^ self class return42
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> returnBlockValue [
	
	^ [ 1 . 5 ] value
]

{ #category : #'chapter 1 - Structural' }
CInterpretable >> returnBoolean [

	^ false
]

{ #category : #'chapter 1 - Structural' }
CInterpretable >> returnEmptyArray [

	^ #()
]

{ #category : #'level5 - class messages' }
CInterpretable >> returnExplicitClass42 [

	^ CInterpretable return42
]

{ #category : #'chapter 1 - Structural' }
CInterpretable >> returnFloat [

	^ 3.14
]

{ #category : #'chapter 1 - Structural' }
CInterpretable >> returnGlobal [

	^ Global
]

{ #category : #'chapter 1 - Structural' }
CInterpretable >> returnInteger [

	^ 5
]

{ #category : #'level4 - message' }
CInterpretable >> returnLast [

	^ self returnLastOf: 10 and: 20
]

{ #category : #'level4 - message' }
CInterpretable >> returnLastOf2: b and: a [

	^ self returnLastOf: b and: a
]

{ #category : #'level4 - message' }
CInterpretable >> returnLastOf: a and: b [

	^ b
]

{ #category : #'chapter 1 - Structural' }
CInterpretable >> returnLiteralArray [

	^ #(true 1 'ahah')
]

{ #category : #'chapter 1 - Structural' }
CInterpretable >> returnSelf [

	^ self
]

{ #category : #'chapter 1 - Structural' }
CInterpretable >> returnSuper [

	^ super
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> returnUnassignedTemp [

	| temp |
	^ temp
]

{ #category : #'chapter 1 - Structural' }
CInterpretable >> returnX [

	^ x 
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> sendMessageInSuperclass [

	^ self methodNotInSubclass
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> sendMessageReturnX [

	^ self returnX
]

{ #category : #'level4 - message' }
CInterpretable >> sendMessageToClass [

	^ CInterpretable new
]

{ #category : #'level3 - temporaries' }
CInterpretable >> settingAValueToTemp [

	| temp | 
	temp := 10.
	^ temp
]

{ #category : #'level3 - temporaries' }
CInterpretable >> settingAValueToTempEmbedded [

	| temp1 temp2 | 
	temp2 := temp1 := 10.
	^ temp2
]

{ #category : #'level3 - temporaries' }
CInterpretable >> settingAValueToTempInARow [

	| temp1 temp2| 
	temp1 := 10.
	temp2 := temp1.
	^ temp2
]

{ #category : #'level6 - super basic block' }
CInterpretable >> simpleBlock [

	^ [  5 ]
]

{ #category : #'chapter 1 - Structural' }
CInterpretable >> store100IntoX [

	x := 100.
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> superMessageSend [

	^ super methodNotInSubclass
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> writeCollaboratorTemporaryVariable [

	| temp |
	temp := 17.
	collaborator writeTemporaryVariable.
	^ temp
]

{ #category : #'chapter 3 - Blocks' }
CInterpretable >> writeInstanceVariableInBlock [

	^ [ x := 17 ] value
]

{ #category : #'chapter 2 - message / activations' }
CInterpretable >> writeTemporaryVariable [

	| temp |
	temp := 100.
	^ temp
]

{ #category : #accessing }
CInterpretable >> x [

	^ x
]

{ #category : #accessing }
CInterpretable >> x: anInteger [

	x := anInteger
]
