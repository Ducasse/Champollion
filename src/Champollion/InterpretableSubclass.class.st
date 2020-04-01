Class {
	#name : #InterpretableSubclass,
	#superclass : #Interpretable,
	#category : #'Champollion-Core'
}

{ #category : #'instance variable access' }
InterpretableSubclass >> not [

	^ super not & false not
]

{ #category : #'instance variable access' }
InterpretableSubclass >> returnFive [

	^ super returnFive + super returnFive 
]
