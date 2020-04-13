Class {
	#name : #CInterpretable,
	#superclass : #Object,
	#instVars : [
		'x'
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

{ #category : #'level5 - class messages' }
CInterpretable >> return42 [

	^ self class return42
]

{ #category : #'level2 - simple constant' }
CInterpretable >> returnEmptyArray [

	^ #()
]

{ #category : #'level5 - class messages' }
CInterpretable >> returnExplicitClass42 [

	^ CInterpretable return42
]

{ #category : #'level2 - simple constant' }
CInterpretable >> returnFalse [

	^ false
]

{ #category : #'level2 - simple constant' }
CInterpretable >> returnFive [

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

{ #category : #'level2 - simple constant' }
CInterpretable >> returnLiteralArray [

	^ #(true 1 'ahah')
]

{ #category : #'level4 - message' }
CInterpretable >> returnSelf [

	^ self
]

{ #category : #'level2 - instance variable access' }
CInterpretable >> returnX [

	^ x 
]

{ #category : #'level4 - message' }
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

{ #category : #'level2 - instance variable access' }
CInterpretable >> store100IntoX [

	x := 100.
]

{ #category : #'level2 - instance variable access' }
CInterpretable >> store100IntoXAndReturnX [

	x := 100.
	
]

{ #category : #helpers }
CInterpretable >> x [

	^ x
]

{ #category : #helpers }
CInterpretable >> x: anInteger [

	x := anInteger
]
