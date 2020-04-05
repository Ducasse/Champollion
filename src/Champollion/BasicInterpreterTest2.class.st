Class {
	#name : #BasicInterpreterTest2,
	#superclass : #TestCase,
	#category : #'Champollion-Level2'
}

{ #category : #hooks }
BasicInterpreterTest2 >> interpreter [

	^ self interpreterClass new
]

{ #category : #hooks }
BasicInterpreterTest2 >> interpreterClass [ 

	^ BasicInterpreter2
]

{ #category : #'level1 - state access' }
BasicInterpreterTest2 >> testAccessXInInstance [

	| ast result |
	ast := (CInterpretable >> #returnX) ast.
	result := self interpreter execute: ast withReceiver: (CInterpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level3 - lookup' }
BasicInterpreterTest2 >> testLookupMessageInSuperclass [

	| ast result |
	ast := (CInterpretable >> #sendMessageReturnX) ast.
	result := self interpreter execute: ast withReceiver: (CInterpretableSubclass new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level1 - return constant' }
BasicInterpreterTest2 >> testReturnConstant [

	| ast result |
	ast := (CInterpretable >> #returnFive) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 5
]

{ #category : #'level1 - return constant' }
BasicInterpreterTest2 >> testReturnFalse [

	| ast result |
	ast := (CInterpretable >> #returnFalse) ast.
	result := self interpreter execute: ast. 
	self deny: result 
]

{ #category : #'level3 - dead simple message' }
BasicInterpreterTest2 >> testReturnSelf [
	"
	returnSelf

		^ self
	"
	| ast result object |
	ast := (CInterpretable >> #returnSelf) ast.
	object := (CInterpretable new x: 100; yourself).
	result := self interpreter execute: ast withReceiver: object.
	self assert: result equals: object 
	
]

{ #category : #'level3 - dead simple message' }
BasicInterpreterTest2 >> testSendMessageReturnX [
	"
	sendMessageReturnX

		^ self returnX
	"
	| ast result |
	ast := (CInterpretable >> #sendMessageReturnX) ast.
	result := self interpreter execute: ast withReceiver: (CInterpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level2 - tmps' }
BasicInterpreterTest2 >> testSettingAValueToTemp [

	| ast result |
	ast := (CInterpretable >> #settingAValueToTemp) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 10 
]

{ #category : #'level2 - tmps' }
BasicInterpreterTest2 >> testSettingAValueToTempEmbedded [
	"settingAValueToTempEmbedded

		| temp1 temp2 | 
		temp2 := temp1 := 10.
		^ temp2
	"
	| ast result |
	ast := (CInterpretable >> #settingAValueToTempEmbedded) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 10 
]

{ #category : #'level2 - tmps' }
BasicInterpreterTest2 >> testSettingAValueToTempInARow [
	"settingAValueToTempInARow

		| temp1 temp2| 
		temp1 := 10.
		temp2 := temp1.
		^ temp2
	"
	| ast result |
	ast := (CInterpretable >> #settingAValueToTempInARow) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 10 
]

{ #category : #'level2 - store instance variable' }
BasicInterpreterTest2 >> testStore100IntoX [

	| ast result object |
	ast := (CInterpretable >> #store100IntoX) ast.
	object := CInterpretable new. 
	result := self interpreter execute: ast withReceiver: object. 
	self assert: object x equals: 100
	
]
