Class {
	#name : #CHBlock,
	#superclass : #Object,
	#instVars : [
		'code',
		'definingContext'
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
CHBlock >> definingContext [
	^ definingContext
]

{ #category : #accessing }
CHBlock >> definingContext: aContext [
	
	definingContext := aContext
]

{ #category : #accessing }
CHBlock >> value [
	<primitive: 201>
  "If the fallback code executes it means that block evaluation failed.
  Return nil for now in such case."
  ^ nil
]

{ #category : #accessing }
CHBlock >> value: anArg [
	"Activate the receiver, creating a closure activation (MethodContext)
	 whose closure is the receiver and whose caller is the sender of this message.
	 Supply the argument and copied values to the activation as its arguments and copied temps.
	 Primitive. Optional (but you're going to want this for performance)."	 
	<primitive: 202>
	^ nil
]
