Class {
	#name : #CHGlobalScope,
	#superclass : #CHScope,
	#instVars : [
		'globalsDictionary'
	],
	#category : #'Champollion-Core'
}

{ #category : #accessing }
CHGlobalScope >> at: aKey put: aValue [

	globalsDictionary at: aKey put: aValue
]

{ #category : #accessing }
CHGlobalScope >> globalsDictionary [
	^ globalsDictionary
]

{ #category : #accessing }
CHGlobalScope >> globalsDictionary: anObject [
	globalsDictionary := anObject
]

{ #category : #accessing }
CHGlobalScope >> initialize [

	super initialize.
	globalsDictionary := Dictionary new
]

{ #category : #'meta-object-protocol' }
CHGlobalScope >> read: aString [ 
	
	^ globalsDictionary at: aString
]

{ #category : #testing }
CHGlobalScope >> scopeDefining: aString [ 
	"I'm the root scope..."
	^ self
]
