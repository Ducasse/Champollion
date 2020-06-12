Class {
	#name : #CHBlock,
	#superclass : #Object,
	#instVars : [
		'code',
		'outerContext'
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
CHBlock >> outerContext [
	^ outerContext
]

{ #category : #accessing }
CHBlock >> outerContext: anObject [
	outerContext := anObject
]

{ #category : #accessing }
CHBlock >> value [

	"AST interpreter primitive.
	This will call"
	<astInterpreterPrimitive: #value>
	
	"If there "
	self halt.
]

{ #category : #accessing }
CHBlock >> value: argument [

	"AST interpreter primitive.
	This will call"
	<astInterpreterPrimitive: #value>
	
	"If there "
	self halt.
]
