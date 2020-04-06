Class {
	#name : #CBasicInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter'
	],
	#category : #'Champollion-Core'
}

{ #category : #hooks }
CBasicInterpreterTest >> interpreter [

	^ interpreter
]

{ #category : #hooks }
CBasicInterpreterTest >> interpreterClass [ 

	^ CBasicInterpreter
]

{ #category : #hooks }
CBasicInterpreterTest >> setUp [

	interpreter := self interpreterClass new
]

{ #category : #'level1 - state access' }
CBasicInterpreterTest >> testAccessXInInstance [

	| ast result |
	ast := (CInterpretable >> #returnX) ast.
	result := self interpreter execute: ast withReceiver: (CInterpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #skipped }
CBasicInterpreterTest >> testClassPointCreation [
	"
	pointCreation

		^ 10 @ 20
	"
	| ast result | 
	self skip.
	ast := (CInterpretable >> #pointCreation) ast.
	result := self interpreter execute: ast withReceiver: CInterpretable new andArguments:{}.
	self assert: result class equals: Point. 
	self assert: result x equals: 10. 
	self assert: result y equals: 20. 
	
]

{ #category : #'level5 - simple blocks' }
CBasicInterpreterTest >> testExecutingSimpleBlock [
	"
	executingSimpleBlock

		^ [  5 ] value
	"
	| ast result |
	ast := (CInterpretable >> #executingSimpleBlock) ast.
	result := self interpreter execute: ast.
	self assert: result equals: 5

]

{ #category : #'level4 - messages to other' }
CBasicInterpreterTest >> testIndirectMessageToClass [
	"
	return42
		^ self class return42
	"
	| ast result |
	ast := (CInterpretable >> #return42) ast.
	result := self interpreter execute: ast withReceiver: CInterpretable new andArguments: {  }.
	self assert: result equals: 42 
	
]

{ #category : #'level4 - messages to other' }
CBasicInterpreterTest >> testIsLiteral [
	"
	not

		^ false not
	"
	| ast result |
	ast := (CInterpretable >> #isLiteral) ast.
	result := self interpreter execute: ast.
	self assert: result

]

{ #category : #'level3 - lookup' }
CBasicInterpreterTest >> testLookupMessageInSuperclass [

	| ast result |
	ast := (CInterpretable >> #sendMessageReturnX) ast.
	result := self interpreter execute: ast withReceiver: (CInterpretableSubclass new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #'level4 - messages to other' }
CBasicInterpreterTest >> testMessageToClass [
	"
	return42

		^ 42
	"
	| ast result |
	ast := (CInterpretable class >> #return42) ast.
	result := self interpreter execute: ast withReceiver: CInterpretable andArguments: {  }.
	self assert: result equals: 42 
	
]

{ #category : #'level4 - stack - envs' }
CBasicInterpreterTest >> testNewFrameIsCorrectlyCreated [

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
CBasicInterpreterTest >> testNot [
	"
	not

		^ false not
	"
	| ast result |
	ast := (CInterpretable >> #not) ast.
	result := self interpreter execute: ast.
	self assert: result

]

{ #category : #skipped }
CBasicInterpreterTest >> testPointCreation [
	"
	pointCreation

		^ 10 @ 20
	"
	| ast result | 
	self skip.
	ast := (CInterpretable >> #pointCreation) ast.
	result := self interpreter execute: ast withReceiver: CInterpretable new andArguments:{}.
	self assert: result class equals: Point. 
	self assert: result x equals: 10. 
	self assert: result y equals: 20. 
	
]

{ #category : #'level4 - messages to other' }
CBasicInterpreterTest >> testPrimitiveAddition [
	"
	addition

		^ 3 + 2
	"
	| ast result |
	ast := (CInterpretable >> #addition) ast.
	result := self interpreter execute: ast.
	self assert: result  equals: 5. 

]

{ #category : #'level1 - return constant' }
CBasicInterpreterTest >> testReturnConstant [

	| ast result |
	ast := (CInterpretable >> #returnFive) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 5
]

{ #category : #'level1 - return constant' }
CBasicInterpreterTest >> testReturnEmptyArray [

	| ast result |
	ast := (CInterpretable >> #returnEmptyArray) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: #() 
]

{ #category : #'level4 - messages to other' }
CBasicInterpreterTest >> testReturnExplicitClass42 [
	"
	return42
		^ self class return42
	"
	| ast result |
	ast := (CInterpretable >> #returnExplicitClass42) ast.
	result := self interpreter execute: ast withReceiver: CInterpretable new andArguments: {  }.
	self assert: result equals: 42 
	
]

{ #category : #'level1 - return constant' }
CBasicInterpreterTest >> testReturnFalse [

	| ast result |
	ast := (CInterpretable >> #returnFalse) ast.
	result := self interpreter execute: ast. 
	self deny: result 
]

{ #category : #'level4 - messages to other' }
CBasicInterpreterTest >> testReturnFive10 [
	"
	returnFive

		^ super returnFive + super returnFive 
	"
	| ast result |
	ast := (CInterpretableSubclass >> #returnFive) ast.
	result := self interpreter execute: ast withReceiver: CInterpretableSubclass new andArguments: #().
	self assert: result  equals: 10. 

]

{ #category : #'level4 - messages to other' }
CBasicInterpreterTest >> testReturnLast [
	"
	returnLast
		^ self returnLastOf: 10 and: 20
	returnLastOf: a and: b
		^ b
	"
	| ast result |
	ast := (CInterpretable >> #returnLast) ast.
	result := self interpreter execute: ast withReceiver: CInterpretable new.
	self assert: result  equals: 20. 

]

{ #category : #'level4 - messages to other' }
CBasicInterpreterTest >> testReturnLastOfAnd [
	"
	returnLastOf: a and: b
		^ b
	"
	| ast result |
	ast := (CInterpretable >> #returnLastOf:and:) ast.
	result := self interpreter execute: ast withReceiver: CInterpretable new andArguments: { 10 . 20}.
	self assert: result  equals: 20. 

]

{ #category : #'level4 - messages to other' }
CBasicInterpreterTest >> testReturnLastOfAnd2 [
	"
	returnLastOf2: b and: a
		^ self returnLastOf: b and: a
	returnLastOf: a and: b
		^ b
	"
	| ast result |
	ast := (CInterpretable >> #returnLastOf2:and:) ast.
	result := self interpreter execute: ast withReceiver: CInterpretable new andArguments: { 10 . 20}.
	self assert: result  equals: 20. 

]

{ #category : #'level1 - return constant' }
CBasicInterpreterTest >> testReturnLiteralArray [

	| ast result |
	ast := (CInterpretable >> #returnLiteralArray) ast.
	result := self interpreter execute: ast. 
	self assert: result equals:  #(true 1 'ahah')
]

{ #category : #'level3 - dead simple message' }
CBasicInterpreterTest >> testReturnSelf [
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
CBasicInterpreterTest >> testSendMessageReturnX [
	"
	sendMessageReturnX

		^ self returnX
	"
	| ast result |
	ast := (CInterpretable >> #sendMessageReturnX) ast.
	result := self interpreter execute: ast withReceiver: (CInterpretable new x: 100).
	self assert: result equals: 100. 
	
]

{ #category : #skipped }
CBasicInterpreterTest >> testSendNewClass [
	"
	sendMessageToClass

		^ Interpretable new
	"
	| ast result |
	self skip.
	ast := (CInterpretable >> #sendMessageToClass) ast.
	result := self interpreter execute: ast.
	self assert: result class equals: CInterpretable. 
	
]

{ #category : #'level2 - tmps' }
CBasicInterpreterTest >> testSettingAValueToTemp [

	| ast result |
	ast := (CInterpretable >> #settingAValueToTemp) ast.
	result := self interpreter execute: ast. 
	self assert: result equals: 10 
]

{ #category : #'level2 - tmps' }
CBasicInterpreterTest >> testSettingAValueToTempEmbedded [
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
CBasicInterpreterTest >> testSettingAValueToTempInARow [
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

{ #category : #'level5 - simple blocks' }
CBasicInterpreterTest >> testSimpleBlock [
	"
	simpleBlock

		^ [  5 ]
	"
	| ast result |
	ast := (CInterpretable >> #simpleBlock) ast.
	result := self interpreter execute: ast.
	self assert: result class equals: CBlock

]

{ #category : #'level4 - stack - envs' }
CBasicInterpreterTest >> testStackIsCorrectlyCreated [

	self deny: self interpreter stack top hasParent. 
	self assert: self interpreter stack size equals: 1. 
	self assert: self interpreter stack top properties isEmpty
]

{ #category : #'level2 - store instance variable' }
CBasicInterpreterTest >> testStore100IntoX [

	| ast result object |
	ast := (CInterpretable >> #store100IntoX) ast.
	object := CInterpretable new. 
	result := self interpreter execute: ast withReceiver: object. 
	self assert: object x equals: 100
	
]

{ #category : #'level4 - messages to other' }
CBasicInterpreterTest >> testSuperNot [
	"
	not
		^ super not & false not
	"
	| ast result |
	ast := (CInterpretableSubclass >> #not) ast.
	result := self interpreter execute: ast withReceiver: CInterpretableSubclass new andArguments: #().
	self assert: result

]
