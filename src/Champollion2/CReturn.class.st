Class {
	#name : 'CReturn',
	#superclass : 'Error',
	#instVars : [
		'value',
		'homeFrame'
	],
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'accessing' }
CReturn >> homeFrame [

	^ homeFrame
]

{ #category : 'accessing' }
CReturn >> homeFrame: anObject [

	homeFrame := anObject
]

{ #category : 'accessing' }
CReturn >> value [

	^ value
]

{ #category : 'accessing' }
CReturn >> value: anObject [

	value := anObject
]
