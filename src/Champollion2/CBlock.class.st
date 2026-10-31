Class {
	#name : 'CBlock',
	#superclass : 'Object',
	#instVars : [
		'code',
		'definingContext'
	],
	#category : 'Champollion2',
	#package : 'Champollion2'
}

{ #category : 'accessing' }
CBlock >> code [
	^ code
]

{ #category : 'accessing' }
CBlock >> code: anOCBlockNode [ 
	code := anOCBlockNode
]

{ #category : 'accessing' }
CBlock >> definingContext [

	^ definingContext
]

{ #category : 'accessing' }
CBlock >> definingContext: anObject [

	definingContext := anObject
]

{ #category : 'printing' }
CBlock >> printOn: aStream [

	super printOn: aStream. 
	aStream nextPutAll: ' - '.
	aStream print: code
]

{ #category : 'evaluating' }
CBlock >> value [
	<primitive: 207>
	"If the fallback code executes it means that block evaluation failed.
	Return nil for now in such case."
	^ nil
]

{ #category : 'evaluating' }
CBlock >> value: anObject [
	<primitive: 207>
	"If the fallback code executes it means that block evaluation failed.
	Return nil for now in such case."
	^ nil
]

{ #category : 'evaluating' }
CBlock >> whileFalse: aBlock [
	"Evaluate the argument, aBlock, as long as the value of the receiver is false."
	
	self value ifFalse: [ aBlock value. self whileFalse: aBlock ].
]

{ #category : 'evaluating' }
CBlock >> whileTrue: aBlock [
	
	self value ifTrue: [ aBlock value. self whileTrue: aBlock ].
]
