Extension { #name : 'RBMethodNode' }

{ #category : '*Champollion2' }
RBMethodNode >> semanticScope: aSemanticScope [
	compilationContext ifNil: [
		compilationContext := aSemanticScope targetClass compiler compilationContext].
	self scope: aSemanticScope.
	self compilationContext semanticScope: aSemanticScope
]
