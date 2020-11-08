Class {
	#name : #CHReturn,
	#superclass : #Error,
	#instVars : [
		'value',
		'homeFrame'
	],
	#category : #'Champollion-Core'
}

{ #category : #accessing }
CHReturn >> homeFrame [
	
	^ homeFrame
]

{ #category : #accessing }
CHReturn >> homeFrame: aCollection [ 
	homeFrame := aCollection
]

{ #category : #accessing }
CHReturn >> value [
	^ value
]

{ #category : #accessing }
CHReturn >> value: anObject [
	value := anObject
]
