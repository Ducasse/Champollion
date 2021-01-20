Class {
	#name : #CHScope,
	#superclass : #Object,
	#category : #'Champollion-Core'
}

{ #category : #testing }
CHScope >> hasDefiningContext [
	
	^ false
]

{ #category : #testing }
CHScope >> isMethodScope [
	
	^ false
]

{ #category : #testing }
CHScope >> scopeDefining: aString [

	self subclassResponsibility 
]
