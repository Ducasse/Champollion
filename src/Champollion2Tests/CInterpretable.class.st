Class {
	#name : 'CInterpretable',
	#superclass : 'Object',
	#category : 'Champollion2Tests',
	#package : 'Champollion2Tests'
}

{ #category : 'returning' }
CInterpretable >> returnBoolean [
	^ false

]

{ #category : 'returning' }
CInterpretable >> returnEmptyLiteralArray [
	^ #()

]

{ #category : 'returning' }
CInterpretable >> returnFloat [

	^ 3.14
]

{ #category : 'returning' }
CInterpretable >> returnInteger [

	^ 5
]

{ #category : 'returning' }
CInterpretable >> returnRecursiveLiteralArray [
	^ #(true 1 #('ahah'))

]

{ #category : 'returning' }
CInterpretable >> returnSelf [

	^ self
]
