Class {
	#name : 'CGlobalScope',
	#superclass : 'Object',
	#instVars : [
		'globalDictionary'
	],
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'accessing' }
CGlobalScope >> at: aKey ifAbsent: aBlock [

	^ globalDictionary at: aKey ifAbsent: aBlock
]

{ #category : 'accessing' }
CGlobalScope >> at: aKey put: aValue [

	globalDictionary at: aKey put: aValue
]

{ #category : 'accessing' }
CGlobalScope >> globalDictionary: anObject [ 
	globalDictionary := anObject
]

{ #category : 'initialization' }
CGlobalScope >> initialize [
	super initialize.
	globalDictionary := Dictionary new

]

{ #category : 'reading' }
CGlobalScope >> read: aString [
 
	^ globalDictionary at: aString
]

{ #category : 'query' }
CGlobalScope >> scopeDefining: aString [
	"I'm the root scope..."
	^ self

]
