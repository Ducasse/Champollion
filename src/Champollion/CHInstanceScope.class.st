Class {
	#name : #CHInstanceScope,
	#superclass : #CHScope,
	#instVars : [
		'receiver',
		'parentScope'
	],
	#category : #'Champollion-Core'
}

{ #category : #accessing }
CHInstanceScope >> definedVariables [
	
	^ receiver class allInstVarNames 
]

{ #category : #accessing }
CHInstanceScope >> parentScope [
	^ parentScope
]

{ #category : #accessing }
CHInstanceScope >> parentScope: anObject [
	parentScope := anObject
]

{ #category : #accessing }
CHInstanceScope >> read: aString [ 
	
	^ receiver instVarNamed: aString
]

{ #category : #accessing }
CHInstanceScope >> receiver [
	^ receiver
]

{ #category : #accessing }
CHInstanceScope >> receiver: aCHInterpretable [ 
	receiver := aCHInterpretable
]

{ #category : #testing }
CHInstanceScope >> scopeDefining: aString [
	
	(self definedVariables includes: aString)
		ifTrue: [ ^ self ].
	
	^ self parentScope scopeDefining: aString
]

{ #category : #asd }
CHInstanceScope >> write: aString withValue: anInteger [ 
	
	receiver instVarNamed: aString put: anInteger
]
