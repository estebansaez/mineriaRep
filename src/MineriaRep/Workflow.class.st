Class {
	#name : #Workflow,
	#superclass : #Object,
	#instVars : [
		'repoOwner',
		'repoName',
		'workflowName',
		'filePath',
		'versions',
		'rawJson'
	],
	#category : #'MineriaRep-Model'
}

{ #category : #'as yet unclassified' }
Workflow class >> fromDictionary: aDict [
    | versionsList |
    versionsList := (aDict at: 'versions') collect: [:each |
        VulnerabilityVersion fromDictionary: each].
    ^ self new
        fileName: (aDict at: 'fileName');
        versions: versionsList;
        yourself.
]

{ #category : #'instance creation' }
Workflow class >> fromJsonDict: aDict filePath: path [
    | history keysOrdered |
    history := aDict at: 'history' ifAbsent: [ Dictionary new ].
    keysOrdered := history keys asSortedCollection.
    ^ self new
        repoOwner: (aDict at: 'repo_owner' ifAbsent: [ 'unknown' ]);
        repoName: (aDict at: 'repo_name' ifAbsent: [ 'unknown' ]);
        workflowName: (aDict at: 'workflow_name' ifAbsent: [ path asString ]);
        filePath: path;
        versions: (keysOrdered collect: [:ts | VulnerabilityVersion fromTimestamp: ts entry: (history at: ts)]);
        rawJson: aDict;
        yourself

]

{ #category : #accessing }
Workflow >> fileName [
    ^ fileName.
]

{ #category : #accessing }
Workflow >> fileName: aString [
    fileName := aString.
]

{ #category : #accessing }
Workflow >> filePath [
    ^ filePath

]

{ #category : #accessing }
Workflow >> filePath: p [
    filePath := p

]

{ #category : #accessing }
Workflow >> fromJsonDict: aDict filePath: path [
    | history keysOrdered |
    history := aDict at: 'history' ifAbsent: [ Dictionary new ].

    keysOrdered := history keys asSortedCollection.

    ^ self new
        repoOwner: (aDict at: 'repo_owner' ifAbsent: [ 'unknown' ]);
        repoName: (aDict at: 'repo_name' ifAbsent: [ 'unknown' ]);
        workflowName: (aDict at: 'workflow_name' ifAbsent: [ path asString ]);
        filePath: path;
        versions: (keysOrdered collect: [:ts |
            VulnerabilityVersion fromTimestamp: ts entry: (history at: ts)
        ]);
        rawJson: aDict;
        yourself
]

{ #category : #'as yet unclassified' }
Workflow >> gtMetricsFor: aView [
    <gtView>
    ^ aView columnedList
        title: 'VulnerabilidadesPorVersion';
        priority: 100;
        items: [ 
            self versions collect: [:ver |
                {
                    ver timestamp.
                    ver vulnerabilities size.
                }
            ]
        ];
        column: 'Version' text: [:row | row first];
        column: 'Vulnerabilities' text: [:row | row second asString];
        yourself.

]

{ #category : #'as yet unclassified' }
Workflow >> gtVersionsFor: aView [
    <gtView>
    ^ aView text
        title: 'Nro Versiones';
        priority: 100;
        text: [
            ('Workflow: ', self workflowName, String cr,
             'Versions: ', self versions size asString) asRopedText
        ].

]

{ #category : #'gt-views' }
Workflow >> gtWorkflowsOverview: aView [
    <gtView>
    | vis |
    vis := WorkflowVisualizer new.
    vis workflows: (Array with: self).
    ^ aView explicit
        title: 'Vista_Grafica';
        stencil: [ vis visualizeWorkflowsOverview ];
        priority: 100;
        yourself.

]

{ #category : #metrics }
Workflow >> numberOfVersions [
    ^ (self versions) size

]

{ #category : #accessing }
Workflow >> rawJson [
    ^ rawJson

]

{ #category : #accessing }
Workflow >> rawJson: d [
    rawJson := d

]

{ #category : #accessing }
Workflow >> repoName [
    ^ repoName

]

{ #category : #accessing }
Workflow >> repoName: s [
    repoName := s

]

{ #category : #accessing }
Workflow >> repoOwner [
    ^ repoOwner

]

{ #category : #accessing }
Workflow >> repoOwner: s [
    repoOwner := s

]

{ #category : #metrics }
Workflow >> totalVulnerabilities [
    ^ (self versions) inject: 0 into: [:sum :v | sum + (v vulnerabilityCount)]

]

{ #category : #accessing }
Workflow >> versions [
    ^ versions

]

{ #category : #accessing }
Workflow >> versions: aCollection [
    versions := aCollection

]

{ #category : #metrics }
Workflow >> vulnerabilitiesPerVersion [
    ^ (self versions) collect: [:v | v timestamp -> v vulnerabilityCount]

]

{ #category : #accessing }
Workflow >> workflowName [
    ^ workflowName

]

{ #category : #accessing }
Workflow >> workflowName: s [
    workflowName := s

]
