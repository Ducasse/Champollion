Class {
	#name : 'CMethodScope',
	#superclass : 'Object',
	#instVars : [
		'receiver',
		'parentScope',
		'variables'
	],
	#category : 'Champollion2-Scopes',
	#package : 'Champollion2',
	#tag : 'Scopes'
}

{ #category : 'accessing' }
CMethodScope >> at: aKey put: aValue [
	variables at: aKey put: aValue
]

{ #category : 'initialization' }
CMethodScope >> initialize [

	super initialize.
	variables := Dictionary new.
]

{ #category : 'accessing' }
CMethodScope >> parentScope [

	^ parentScope
]

{ #category : 'accessing' }
CMethodScope >> parentScope: anObject [

	parentScope := anObject
]

{ #category : 'reading' }
CMethodScope >> read: aString [
	^ variables at: aString
]

{ #category : 'accessing' }
CMethodScope >> receiver [

	^ receiver
]

{ #category : 'accessing' }
CMethodScope >> receiver: anObject [

	receiver := anObject
]

{ #category : 'query' }
CMethodScope >> scopeDefining: aString [
	(variables includesKey: aString)
		ifTrue: [ ^ self ].

	^ self parentScope scopeDefining: aString
]

{ #category : 'reading' }
CMethodScope >> write: aString withValue: aValue [
	variables at: aString put: aValue
]
