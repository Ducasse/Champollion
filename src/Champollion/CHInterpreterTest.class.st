Class {
	#name : #CHInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'receiver'
	],
	#category : #'Champollion-Core'
}

{ #category : #'chapter one' }
CHInterpreterTest >> executeSelector: aSymbol [

	| ast |
	ast := (CInterpretable >> aSymbol) ast.
	^ self interpreter executeMethod: ast withReceiver: receiver. 
	
]

{ #category : #hooks }
CHInterpreterTest >> interpreter [

	^ interpreter
]

{ #category : #hooks }
CHInterpreterTest >> interpreterClass [ 

	^ CHInterpreter
]

{ #category : #hooks }
CHInterpreterTest >> setUp [

	interpreter := self interpreterClass new.
	receiver := CInterpretable new
]

{ #category : #'chapter one' }
CHInterpreterTest >> testReturnAccessInstanceVariable [

	receiver x: 100.
	self assert: (self executeSelector: #returnX) equals: 100
]

{ #category : #'chapter one' }
CHInterpreterTest >> testReturnBoolean [

	self assert: (self executeSelector: #returnBoolean) equals: false
]

{ #category : #'chapter one' }
CHInterpreterTest >> testReturnEmptyArray [

	self assert: (self executeSelector: #returnEmptyArray) equals: #() 
]

{ #category : #'chapter one' }
CHInterpreterTest >> testReturnFloat [

	self assert: (self executeSelector: #returnFloat) equals: 3.14 
]

{ #category : #'chapter one' }
CHInterpreterTest >> testReturnGlobal [

	| globalObject |
	globalObject := Object new.
	interpreter globalEnvironmentAt: #Global put: globalObject. 
	self assert: (self executeSelector: #returnGlobal) equals: globalObject  
]

{ #category : #'chapter one' }
CHInterpreterTest >> testReturnInteger [

	self assert: (self executeSelector: #returnInteger) equals: 5
]

{ #category : #'chapter one' }
CHInterpreterTest >> testReturnLiteralArray [

	self assert: (self executeSelector: #returnLiteralArray) equals: #(true 1 'ahah')
]

{ #category : #'chapter one' }
CHInterpreterTest >> testReturnSelf [

	self assert: (self executeSelector: #returnSelf) equals: receiver
]

{ #category : #'chapter one' }
CHInterpreterTest >> testReturnSuper [

	self assert: (self executeSelector: #returnSuper) equals: receiver
]

{ #category : #'chapter one' }
CHInterpreterTest >> testStoreInstanceVariable [

	receiver x: 17.
	self executeSelector: #store100IntoX.
	self assert: receiver x equals: 100
]
