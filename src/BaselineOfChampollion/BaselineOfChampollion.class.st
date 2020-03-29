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
   		baseline: 'ContainersStack' 
   		with: [ spec repository: 'github://pharo-containers/Containers-Stack:v1.0/src' ].
	spec
		for: #pharo
		do: [ 
			spec
				package: 'Champollion' with: [ spec requires: #('ContainersPropertyEnvironment' 'ContainersStack') ] ]
]
