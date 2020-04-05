Class {
	#name : #CBlock,
	#superclass : #Object,
	#instVars : [
		'body',
		'interpreter'
	],
	#category : #'Champollion-Core'
}

{ #category : #body }
CBlock >> body: aRBBlockNode [ 
	body := aRBBlockNode
]

{ #category : #accessing }
CBlock >> interpreter: aCBasicInterpreter [ 
	interpreter := aCBasicInterpreter
]

{ #category : #evaluating }
CBlock >> value [

	^ interpreter visitNode: body 
]
