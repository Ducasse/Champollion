Class {
	#name : #Interpretable,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #'Champollion-Core'
}

{ #category : #message }
Interpretable >> addition [

	^ 3 + 2
]

{ #category : #message }
Interpretable >> isLiteral [ 
	"isLiteral is defined on the superclass"
	
	^ false isLiteral 
]

{ #category : #message }
Interpretable >> not [

	^ false not
]

{ #category : #message }
Interpretable >> pointCreation [

	^ 10 @ 20
]

{ #category : #'simple constant' }
Interpretable >> returnFalse [

	^ false
]

{ #category : #'simple constant' }
Interpretable >> returnFive [

	^ 5
]

{ #category : #message }
Interpretable >> returnSelf [

	^ self
]

{ #category : #'instance variable access' }
Interpretable >> returnX [

	^ x 
]

{ #category : #message }
Interpretable >> sendMessageReturnX [

	^ self returnX
]

{ #category : #message }
Interpretable >> sendMessageToClass [

	^ Interpretable new
]

{ #category : #temporaries }
Interpretable >> settingAValueToTemp [

	| temp | 
	temp := 10.
	^ temp
]

{ #category : #temporaries }
Interpretable >> settingAValueToTempEmbedded [

	| temp1 temp2 | 
	temp2 := temp1 := 10.
	^ temp2
]

{ #category : #temporaries }
Interpretable >> settingAValueToTempInARow [

	| temp1 temp2| 
	temp1 := 10.
	temp2 := temp1.
	^ temp2
]

{ #category : #'instance variable access' }
Interpretable >> store100IntoX [

	x := 100.
]

{ #category : #'instance variable access' }
Interpretable >> store100IntoXAndReturnX [

	x := 100.
	
]

{ #category : #helpers }
Interpretable >> x [

	^ x
]

{ #category : #helpers }
Interpretable >> x: anInteger [

	x := anInteger
]
