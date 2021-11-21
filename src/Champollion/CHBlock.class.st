Class {
	#name : #CHBlock,
	#superclass : #Object,
	#instVars : [
		'code',
		'definingContext',
		'interpreter'
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
CHBlock >> definingClass [

	^ code methodNode propertyAt: #definingClass
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
CHBlock >> interpreter [
	^ interpreter 
]

{ #category : #accessing }
CHBlock >> interpreter: anInterpreter [

	interpreter := anInterpreter
]

{ #category : #accessing }
CHBlock >> value [

	<primitive: 201>
	
	| result |
	interpreter pushNewFrame.
	interpreter receiver: self.
	interpreter tempAt: #__method put: code.
	code propertyAt: #definingClass put: self definingClass. 
	result := interpreter primitiveBlockValue.
	interpreter popFrame.
	^ result 
]

{ #category : #accessing }
CHBlock >> value: anArg [

	<primitive: 202>
	
	| result |
	interpreter pushNewFrame.
	
	interpreter receiver: self.
	interpreter tempAt: #__method put: code. 
	code propertyAt: #definingClass put: self definingClass. 
	result := interpreter primitiveBlockValueWith.
	interpreter popFrame.
	^ result
]
