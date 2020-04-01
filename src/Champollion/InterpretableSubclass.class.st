Class {
	#name : #InterpretableSubclass,
	#superclass : #Interpretable,
	#category : #'Champollion-Core'
}

{ #category : #'instance variable access' }
InterpretableSubclass >> returnFive [

	^ super returnFive + super returnFive 
]
