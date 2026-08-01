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

{ #category : 'evaluating' }
CBlock >> value [
	<primitive: 207>
	"If the fallback code executes it means that block evaluation failed.
	Return nil for now in such case."
	^ nil
]
