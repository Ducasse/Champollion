Class {
	#name : 'CInterpretable',
	#superclass : 'Object',
	#instVars : [
		'x'
	],
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

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

{ #category : 'accessing' }
CInterpretable >> x [

	^ x
]

{ #category : 'accessing' }
CInterpretable >> x: anObject [

	x := anObject
]
