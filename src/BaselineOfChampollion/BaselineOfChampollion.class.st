Class {
	#name : #BaselineOfChampollion,
	#superclass : #BaselineOf,
	#category : #BaselineOfChampollion
}

{ #category : #baselines }
BaselineOfChampollion >> baseline: spec [
	<baseline>
	spec
		baseline: 'ContainersPropertyEnvironment'
		with: [ spec repository: 'github://Ducasse/Containers-PropertyEnvironment' ].
	spec
		for: #pharo
		do: [ 
			spec
				package: 'Champollion' with: [ spec requires: #('ContainersPropertyEnvironment') ] ]
]
