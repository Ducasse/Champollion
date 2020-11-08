Class {
	#name : #CHBlock,
	#superclass : #Object,
	#instVars : [
		'code',
		'definingContext'
	],
	#category : #'Champollion-Core'
}

{ #category : #accessing }
CHBlock >> code [
	^ code
]

{ #category : #accessing }
CHBlock >> code: aRBBlockNode [
	code := aRBBlockNode
]

{ #category : #accessing }
CHBlock >> definingContext [
	^ definingContext
]

{ #category : #accessing }
CHBlock >> definingContext: aContext [
	
	definingContext := aContext
]

{ #category : #accessing }
CHBlock >> value [
	<primitive: 201>
  "If the fallback code executes it means that block evaluation failed.
  Return nil for now in such case."
  ^ nil
]
