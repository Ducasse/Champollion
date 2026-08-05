Class {
	#name : 'CMethodScope',
	#superclass : 'Object',
	#instVars : [
		'receiver',
		'parentScope',
		'variables'
	],
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'variable accesses' }
CMethodScope >> at: aKey [
	^ variables at: aKey
]

{ #category : 'variable accesses' }
CMethodScope >> at: aKey put: aValue [
	variables at: aKey put: aValue
]

{ #category : 'printing' }
CMethodScope >> currentMethod [

	^ variables at: #___method
]

{ #category : 'testing' }
CMethodScope >> includesVariableName: aName [

	^ variables includesKey: aName
]

{ #category : 'initialization' }
CMethodScope >> initialize [

	super initialize.
	variables := Dictionary new
]

{ #category : 'accessing' }
CMethodScope >> parentScope [

	^ parentScope
]

{ #category : 'accessing' }
CMethodScope >> parentScope: anObject [

	parentScope := anObject
]

{ #category : 'printing' }
CMethodScope >> printOn: aStream [

	super printOn: aStream.
	receiver ifNotNil: [ 
			aStream nextPutAll: ' rec: '.
			receiver printOn: aStream.
			aStream nextPutAll: ' selector: #' , self currentMethod selector ]
]

{ #category : 'scope' }
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

{ #category : 'scope' }
CMethodScope >> scopeDefining: aString [
	(variables includesKey: aString)
		ifTrue: [ ^ self ].
	^ self parentScope scopeDefining: aString
]

{ #category : 'scope' }
CMethodScope >> write: aString withValue: aValue [
	variables at: aString put: aValue
]
