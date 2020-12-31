Class {
	#name : #CHMethodScope,
	#superclass : #CHScope,
	#instVars : [
		'receiver',
		'variables',
		'parentScope'
	],
	#category : #'Champollion-Core'
}

{ #category : #accessing }
CHMethodScope >> at: aKey [

	^ variables at: aKey
]

{ #category : #accessing }
CHMethodScope >> at: aKey put: aValue [

	variables at: aKey put: aValue
]

{ #category : #accessing }
CHMethodScope >> hasDefiningContext [
	
	^ self parentScope isMethodScope
]

{ #category : #testing }
CHMethodScope >> includesKey: aString [ 
	
	^ variables includesKey: aString 
]

{ #category : #accessing }
CHMethodScope >> initialize [

	super initialize.
	variables := Dictionary new.
]

{ #category : #testing }
CHMethodScope >> isMethodScope [
	
	^ true
]

{ #category : #accessing }
CHMethodScope >> parentScope [
	^ parentScope
]

{ #category : #accessing }
CHMethodScope >> parentScope: aScope [
	
	parentScope := aScope
]

{ #category : #'meta-object-protocol' }
CHMethodScope >> read: aString [ 
	
	^ variables at: aString
]

{ #category : #accessing }
CHMethodScope >> receiver [
	^ receiver
]

{ #category : #accessing }
CHMethodScope >> receiver: aCHInterpretable [ 
	receiver := aCHInterpretable
]

{ #category : #testing }
CHMethodScope >> scopeDefining: aString [ 
	
	(variables includesKey: aString)
		ifTrue: [ ^ self ].

	^ self parentScope scopeDefining: aString
]

{ #category : #writing }
CHMethodScope >> write: aString withValue: aValue [
	
	variables at: aString put: aValue
]
