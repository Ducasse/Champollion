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
	ast := (Interpretable >> #returnX) ast.
	result := self interpreter execute: ast withReceiver: (Interpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level3 - lookup' }
BasicInterpreterTest2 >> testLookupMessageInSuperclass [

	| ast result |
	ast := (Interpretable >> #sendMessageReturnX) ast.
	result := self interpreter execute: ast withReceiver: (InterpretableSubclass new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level1 - return constant' }
BasicInterpreterTest2 >> testReturnConstant [

	| ast result |
	ast := (Interpretable >> #returnFive) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 5
]

{ #category : #'level1 - return constant' }
BasicInterpreterTest2 >> testReturnFalse [

	| ast result |
	ast := (Interpretable >> #returnFalse) ast.
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
	ast := (Interpretable >> #returnSelf) ast.
	object := (Interpretable new x: 100; yourself).
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
	ast := (Interpretable >> #sendMessageReturnX) ast.
	result := self interpreter execute: ast withReceiver: (Interpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level2 - tmps' }
BasicInterpreterTest2 >> testSettingAValueToTemp [

	| ast result |
	ast := (Interpretable >> #settingAValueToTemp) ast.
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
	ast := (Interpretable >> #settingAValueToTempEmbedded) ast.
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
	ast := (Interpretable >> #settingAValueToTempInARow) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 10 
]

{ #category : #'level2 - store instance variable' }
BasicInterpreterTest2 >> testStore100IntoX [

	| ast result object |
	ast := (Interpretable >> #store100IntoX) ast.
	object := Interpretable new. 
	result := self interpreter execute: ast withReceiver: object. 
	self assert: object x equals: 100
	
]
