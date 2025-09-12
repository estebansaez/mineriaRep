Class {
	#name : #BaselineOfMineriaRep,
	#superclass : #BaselineOf,
	#category : #BaselineOfMineriaRep
}

{ #category : #loading }
BaselineOfMineriaRep class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'mineriaRep' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfMineriaRep >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'MineriaRep'
		]
]
