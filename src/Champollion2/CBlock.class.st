Class {
	#name : 'CBlock',
	#superclass : 'Object',
	#instVars : [
		'code'
	],
	#category : 'Champollion2-Scopes',
	#package : 'Champollion2',
	#tag : 'Scopes'
}

{ #category : 'accessing' }
CBlock >> code [

	^ code
]

{ #category : 'accessing' }
CBlock >> code: aBlockNode [ 
	code := aBlockNode
]

{ #category : 'accessing' }
CBlock >> value [
	<primitive: 207>
	"If the fallback code executes it means that block evaluation failed.
	Return nil for now in such case."
	^ nil
]
