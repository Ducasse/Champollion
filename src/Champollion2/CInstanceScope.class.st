Class {
	#name : 'CInstanceScope',
	#superclass : 'Object',
	#instVars : [
		'receiver',
		'parentScope'
	],
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'accessing' }
CInstanceScope >> definedVariables [
	^ receiver class allInstVarNames 
]

{ #category : 'accessing' }
CInstanceScope >> parentScope [

	^ parentScope
]

{ #category : 'accessing' }
CInstanceScope >> parentScope: anObject [

	parentScope := anObject
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
	
	^ self parentScope scopeDefining: aString
]

{ #category : 'reading' }
CInstanceScope >> write: aString withValue: anInteger [
	receiver instVarNamed: aString put: anInteger
]
