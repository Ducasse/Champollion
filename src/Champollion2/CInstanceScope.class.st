Class {
	#name : 'CInstanceScope',
	#superclass : 'Object',
	#instVars : [
		'receiver'
	],
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'accessing' }
CInstanceScope >> definedVariables [
	^ receiver class allInstVarNames 
]

{ #category : 'reading' }
CInstanceScope >> read: aString [ 
	^ receiver instVarNamed: aString
]

{ #category : 'accessing' }
CInstanceScope >> receiver: anObject [
  	receiver := anObject

]

{ #category : 'query' }
CInstanceScope >> scopeDefining: aString [
	(self definedVariables includes: aString)
		ifTrue: [ ^ self ].
	Error signal: 'Variable ', aString, ' not found'
]

{ #category : 'reading' }
CInstanceScope >> write: aString withValue: anInteger [
	receiver instVarNamed: aString put: anInteger
]
