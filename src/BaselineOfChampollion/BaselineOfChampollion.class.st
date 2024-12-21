Class {
	#name : 'BaselineOfChampollion',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfChampollion',
	#package : 'BaselineOfChampollion'
}

{ #category : 'baselines' }
BaselineOfChampollion >> baseline: spec [

	<baseline>
	spec
		baseline: 'ContainersPropertyEnvironment'
		with: [
		spec repository: 'github://Ducasse/Containers-PropertyEnvironment' ].
	spec baseline: 'ContainersStack' with: [
		spec repository:
			'github://pharo-containers/Containers-Stack:v1.0/src' ].
	spec for: #pharo do: [
		spec package: 'Champollion2' with: [
			spec requires:
				#( 'ContainersPropertyEnvironment' 'ContainersStack' ) ].
		spec package: 'Champollion2Tests' with: [
			spec requires:
				#( 'Champollion2' ) ]]
]
