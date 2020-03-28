Class {
	#name : #BasicInterpreterTest,
	#superclass : #TestCase,
	#category : #'Champollion-Core'
}

{ #category : #hooks }
BasicInterpreterTest >> interpreter [

	^ self interpreterClass new
]

{ #category : #hooks }
BasicInterpreterTest >> interpreterClass [ 

	^ BasicInterpreter
]

{ #category : #'level1 - state access' }
BasicInterpreterTest >> testAccessXInInstance [

	| ast result |
	ast := (Interpretable >> #returnX) ast.
	result := self interpreter execute: ast with: (Interpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level1 - return constant' }
BasicInterpreterTest >> testReturnConstant [

	| ast result |
	ast := (Interpretable >> #returnFive) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 5
]

{ #category : #'level1 - return constant' }
BasicInterpreterTest >> testReturnFalse [

	| ast result |
	ast := (Interpretable >> #returnFalse) ast.
	result := self interpreter execute: ast. 
	self deny: result 
]

{ #category : #'level3 - message' }
BasicInterpreterTest >> testReturnSelf [
	"
	returnSelf

		^ self
	"
	| ast result object |
	ast := (Interpretable >> #returnSelf) ast.
	object := (Interpretable new x: 100; yourself).
	result := self interpreter execute: ast with: object.
	self assert: result equals: object 
	
]

{ #category : #'level3 - message' }
BasicInterpreterTest >> testSendMessageReturnX [
	"
	sendMessageReturnX

		^ self returnX
	"
	| ast result |
	ast := (Interpretable >> #sendMessageReturnX) ast.
	result := self interpreter execute: ast with: (Interpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level2 - tmps' }
BasicInterpreterTest >> testSettingAValueToTemp [

	| ast result |
	ast := (Interpretable >> #settingAValueToTemp) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 10 
]

{ #category : #'level2 - tmps' }
BasicInterpreterTest >> testSettingAValueToTempEmbedded [
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
BasicInterpreterTest >> testSettingAValueToTempInARow [
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
BasicInterpreterTest >> testStore100IntoX [

	| ast result object |
	ast := (Interpretable >> #store100IntoX) ast.
	object := Interpretable new. 
	result := self interpreter execute: ast with: object. 
	self assert: object x equals: 100
	
]
