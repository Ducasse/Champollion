Class {
	#name : 'CInterpretable',
	#superclass : 'Object',
	#instVars : [
		'x',
		'collaborator'
	],
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

{ #category : 'class initialization' }
CInterpretable class >> initialize [ 
	self setUpGlobal
]

{ #category : 'class initialization' }
CInterpretable class >> setUpGlobal [

	self environment at: #Global put: 33
]

{ #category : 'accessing' }
CInterpretable >> collaborator [
	^ collaborator
]

{ #category : 'accessing' }
CInterpretable >> collaborator: aCInterpretable [ 
	collaborator := aCInterpretable
]

{ #category : 'returning literals' }
CInterpretable >> returnBoolean [
	^ false

]

{ #category : 'returning literals' }
CInterpretable >> returnEmptyLiteralArray [
	^ #()

]

{ #category : 'returning literals' }
CInterpretable >> returnFloat [

	^ 3.14
]

{ #category : 'returning variables' }
CInterpretable >> returnGlobal [
	^ Global
]

{ #category : 'returning variables' }
CInterpretable >> returnInstanceVariableX [

	^ x
]

{ #category : 'returning literals' }
CInterpretable >> returnInteger [

	^ 5
]

{ #category : 'returning literals' }
CInterpretable >> returnRecursiveLiteralArray [
	^ #(true 1 #('ahah'))

]

{ #category : 'returning self/super' }
CInterpretable >> returnSelf [

	^ self
]

{ #category : 'returning self/super' }
CInterpretable >> returnSuper [

	^ super
]

{ #category : 'send messages' }
CInterpretable >> sendMessageReturnX [
	^ self returnInstanceVariableX
]

{ #category : 'send messages' }
CInterpretable >> setXAndMessage [
	
	x := 1000.
	collaborator returnInstanceVariableX.
	^ x
]

{ #category : 'assignments' }
CInterpretable >> store100IntoInstanceVariableX [

	^ x := 100
]

{ #category : 'accessing' }
CInterpretable >> x [

	^ x
]

{ #category : 'accessing' }
CInterpretable >> x: anObject [

	x := anObject
]
