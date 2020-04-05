Class {
	#name : #CInterpretableSubclass,
	#superclass : #CInterpretable,
	#category : #'Champollion-Core'
}

{ #category : #'instance variable access' }
CInterpretableSubclass >> not [

	^ super not & false not
]

{ #category : #'instance variable access' }
CInterpretableSubclass >> returnFive [

	^ super returnFive + super returnFive 
]
