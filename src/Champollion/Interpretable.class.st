Class {
	#name : #Interpretable,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #'Champollion-Core'
}

{ #category : #'simple constant' }
Interpretable >> returnFalse [

	^ false
]

{ #category : #'simple constant' }
Interpretable >> returnFive [

	^ 5
]

{ #category : #'instance variable access' }
Interpretable >> returnX [

	^ x 
]

{ #category : #temporaries }
Interpretable >> settingAValueToTemp [

	| temp | 
	temp := 10.
	^ temp
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
Interpretable >> x: anInteger [

	x := anInteger
]
