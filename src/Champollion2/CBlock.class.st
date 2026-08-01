Class {
	#name : 'CBlock',
	#superclass : 'Object',
	#instVars : [
		'code'
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
