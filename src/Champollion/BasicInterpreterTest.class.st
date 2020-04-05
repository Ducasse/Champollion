Class {
	#name : #BasicInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter'
	],
	#category : #'Champollion-Core'
}

{ #category : #hooks }
BasicInterpreterTest >> interpreter [

	^ interpreter
]

{ #category : #hooks }
BasicInterpreterTest >> interpreterClass [ 

	^ BasicInterpreter
]

{ #category : #hooks }
BasicInterpreterTest >> setUp [

	interpreter := self interpreterClass new
]

{ #category : #'level1 - state access' }
BasicInterpreterTest >> testAccessXInInstance [

	| ast result |
	ast := (Interpretable >> #returnX) ast.
	result := self interpreter execute: ast withReceiver: (Interpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #skipped }
BasicInterpreterTest >> testClassPointCreation [
	"
	pointCreation

		^ 10 @ 20
	"
	| ast result | 
	self skip.
	ast := (Interpretable >> #pointCreation) ast.
	result := self interpreter execute: ast withReceiver: Interpretable new andArguments:{}.
	self assert: result class equals: Point. 
	self assert: result x equals: 10. 
	self assert: result y equals: 20. 
	
]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testIndirectMessageToClass [
	"
	return42
		^ self class return42
	"
	| ast result |
	ast := (Interpretable >> #return42) ast.
	result := self interpreter execute: ast withReceiver: Interpretable new andArguments: {  }.
	self assert: result equals: 42 
	
]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testIsLiteral [
	"
	not

		^ false not
	"
	| ast result |
	ast := (Interpretable >> #isLiteral) ast.
	result := self interpreter execute: ast.
	self assert: result

]

{ #category : #'level3 - lookup' }
BasicInterpreterTest >> testLookupMessageInSuperclass [

	| ast result |
	ast := (Interpretable >> #sendMessageReturnX) ast.
	result := self interpreter execute: ast withReceiver: (InterpretableSubclass new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testMessageToClass [
	"
	return42

		^ 42
	"
	| ast result |
	ast := (Interpretable class >> #return42) ast.
	result := self interpreter execute: ast withReceiver: Interpretable andArguments: {  }.
	self assert: result equals: 42 
	
]

{ #category : #'level4 - stack - envs' }
BasicInterpreterTest >> testNewFrameIsCorrectlyCreated [

	| prevEnv newEnv |
	prevEnv := self interpreter stack top.
	prevEnv at: #top put: 1. 
	self deny: prevEnv hasParent. 
	newEnv := self interpreter pushNewFrame.
	newEnv at: #newTop put: 2.  
	self assert: newEnv parent equals: prevEnv.
	self assert: self interpreter stack top equals: newEnv.

]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testNot [
	"
	not

		^ false not
	"
	| ast result |
	ast := (Interpretable >> #not) ast.
	result := self interpreter execute: ast.
	self assert: result

]

{ #category : #skipped }
BasicInterpreterTest >> testPointCreation [
	"
	pointCreation

		^ 10 @ 20
	"
	| ast result | 
	self skip.
	ast := (Interpretable >> #pointCreation) ast.
	result := self interpreter execute: ast withReceiver: Interpretable new andArguments:{}.
	self assert: result class equals: Point. 
	self assert: result x equals: 10. 
	self assert: result y equals: 20. 
	
]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testPrimitiveAddition [
	"
	addition

		^ 3 + 2
	"
	| ast result |
	ast := (Interpretable >> #addition) ast.
	result := self interpreter execute: ast.
	self assert: result  equals: 5. 

]

{ #category : #'level1 - return constant' }
BasicInterpreterTest >> testReturnConstant [

	| ast result |
	ast := (Interpretable >> #returnFive) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 5
]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testReturnExplicitClass42 [
	"
	return42
		^ self class return42
	"
	| ast result |
	ast := (Interpretable >> #returnExplicitClass42) ast.
	result := self interpreter execute: ast withReceiver: Interpretable new andArguments: {  }.
	self assert: result equals: 42 
	
]

{ #category : #'level1 - return constant' }
BasicInterpreterTest >> testReturnFalse [

	| ast result |
	ast := (Interpretable >> #returnFalse) ast.
	result := self interpreter execute: ast. 
	self deny: result 
]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testReturnFive10 [
	"
	returnFive

		^ super returnFive + super returnFive 
	"
	| ast result |
	ast := (InterpretableSubclass >> #returnFive) ast.
	result := self interpreter execute: ast withReceiver: InterpretableSubclass new andArguments: #().
	self assert: result  equals: 10. 

]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testReturnLast [
	"
	returnLast
		^ self returnLastOf: 10 and: 20
	returnLastOf: a and: b
		^ b
	"
	| ast result |
	ast := (Interpretable >> #returnLast) ast.
	result := self interpreter execute: ast withReceiver: Interpretable new.
	self assert: result  equals: 20. 

]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testReturnLastOfAnd [
	"
	returnLastOf: a and: b
		^ b
	"
	| ast result |
	ast := (Interpretable >> #returnLastOf:and:) ast.
	result := self interpreter execute: ast withReceiver: Interpretable new andArguments: { 10 . 20}.
	self assert: result  equals: 20. 

]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testReturnLastOfAnd2 [
	"
	returnLastOf2: b and: a
		^ self returnLastOf: b and: a
	returnLastOf: a and: b
		^ b
	"
	| ast result |
	ast := (Interpretable >> #returnLastOf2:and:) ast.
	result := self interpreter execute: ast withReceiver: Interpretable new andArguments: { 10 . 20}.
	self assert: result  equals: 20. 

]

{ #category : #'level3 - dead simple message' }
BasicInterpreterTest >> testReturnSelf [
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
BasicInterpreterTest >> testSendMessageReturnX [
	"
	sendMessageReturnX

		^ self returnX
	"
	| ast result |
	ast := (Interpretable >> #sendMessageReturnX) ast.
	result := self interpreter execute: ast withReceiver: (Interpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #skipped }
BasicInterpreterTest >> testSendNewClass [
	"
	sendMessageToClass

		^ Interpretable new
	"
	| ast result |
	self skip.
	ast := (Interpretable >> #sendMessageToClass) ast.
	result := self interpreter execute: ast.
	self assert: result class equals: Interpretable. 
	
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

{ #category : #'level4 - stack - envs' }
BasicInterpreterTest >> testStackIsCorrectlyCreated [

	self deny: self interpreter stack top hasParent. 
	self assert: self interpreter stack size equals: 1. 
	self assert: self interpreter stack top properties isEmpty
]

{ #category : #'level2 - store instance variable' }
BasicInterpreterTest >> testStore100IntoX [

	| ast result object |
	ast := (Interpretable >> #store100IntoX) ast.
	object := Interpretable new. 
	result := self interpreter execute: ast withReceiver: object. 
	self assert: object x equals: 100
	
]

{ #category : #'level4 - messages to other' }
BasicInterpreterTest >> testSuperNot [
	"
	not
		^ super not & false not
	"
	| ast result |
	ast := (InterpretableSubclass >> #not) ast.
	result := self interpreter execute: ast withReceiver: InterpretableSubclass new andArguments: #().
	self assert: result

]
