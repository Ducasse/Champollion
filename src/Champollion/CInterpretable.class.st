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

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> changeCollaboratorWithArgument [

	collaborator x: 500
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> changeCollaboratorX [

	collaborator store100IntoX
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> changeCollaboratorXWithConflictingArgumentNAmes [

	self collaboratorXIgnoringArgumentWithSameName: 1987
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> cocollaboratorX: anInteger [

	self collaboratorX: anInteger

	
]

{ #category : #accessing }
CInterpretable >> collaborator: anObject [

	collaborator := anObject
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> collaboratorX [

	^ collaborator x
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> collaboratorX: anInteger [

	collaborator x: anInteger
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> collaboratorXIgnoringArgumentWithSameName: anInteger [
	"precondition: The argument of method x: has name anInteger too, and they should not collide"
	collaborator x: 100
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

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> readArgumentVariableAfterMessageSend [
	
	^ self readArgumentVariableAfterMessageSend: 17
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> readArgumentVariableAfterMessageSend: arg [

	collaborator returnUnassignedTemp.
	^ arg
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> readCollaboratorTemporaryVariable [

	| temp |
	temp := 17.
	^ collaborator returnUnassignedTemp
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> readInstanceVariableAfterMessageSend [

	collaborator returnUnassignedTemp.
	^ x
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> readTemporaryVariable [

	| temp |
	^ temp
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> readTemporaryVariableAfterMessageSend [

	| temp |
	temp := 17.
	collaborator returnUnassignedTemp.
	^ temp
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> redefinedMethod [

	^ super redefinedMethod
]

{ #category : #'level5 - class messages' }
CInterpretable >> return42 [

	^ self class return42
]

{ #category : #'chapitre1 - simple constant' }
CInterpretable >> returnBoolean [

	^ false
]

{ #category : #'chapitre1 - simple constant' }
CInterpretable >> returnEmptyArray [

	^ #()
]

{ #category : #'level5 - class messages' }
CInterpretable >> returnExplicitClass42 [

	^ CInterpretable return42
]

{ #category : #'chapitre1 - simple constant' }
CInterpretable >> returnFloat [

	^ 3.14
]

{ #category : #'chapitre1 - simple constant' }
CInterpretable >> returnGlobal [

	^ Global
]

{ #category : #'chapitre1 - simple constant' }
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

{ #category : #'chapitre1 - simple constant' }
CInterpretable >> returnLiteralArray [

	^ #(true 1 'ahah')
]

{ #category : #'chapitre1 - simple constant' }
CInterpretable >> returnSelf [

	^ self
]

{ #category : #'chapitre1 - simple constant' }
CInterpretable >> returnSuper [

	^ super
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> returnUnassignedTemp [

	| temp |
	^ temp
]

{ #category : #'chapitre1 - simple constant' }
CInterpretable >> returnX [

	^ x 
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> sendMessageInSuperclass [

	^ self methodNotInSubclass
]

{ #category : #'chapitre2 - message / activations' }
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

{ #category : #'chapitre1 - simple constant' }
CInterpretable >> store100IntoX [

	x := 100.
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> superMessageSend [

	^ super methodNotInSubclass
]

{ #category : #'chapitre2 - message / activations' }
CInterpretable >> writeCollaboratorTemporaryVariable [

	| temp |
	temp := 17.
	collaborator writeTemporaryVariable.
	^ temp
]

{ #category : #'chapitre2 - message / activations' }
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
