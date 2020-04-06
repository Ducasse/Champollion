Class {
	#name : #CBlock,
	#superclass : #Object,
	#instVars : [
		'interpreter',
		'blockDefinition'
	],
	#category : #'Champollion-Core'
}

{ #category : #accessing }
CBlock >> blockDefinition [
	^ blockDefinition
]

{ #category : #accessing }
CBlock >> blockDefinition: aRBBlockNode [ 
	blockDefinition := aRBBlockNode
]

{ #category : #accessing }
CBlock >> interpreter: aCBasicInterpreter [ 
	interpreter := aCBasicInterpreter
]

{ #category : #evaluating }
CBlock >> value [

	^ interpreter visitNode: blockDefinition body 
]
