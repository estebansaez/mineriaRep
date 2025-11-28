Class {
	#name : #WorkflowVisualizer,
	#superclass : #Object,
	#instVars : [
		'workflows'
	],
	#category : #'MineriaRep-Model'
}

{ #category : #rendering }
WorkflowVisualizer >> visualizeWorkflowsOverview [
    "Return a simple container with one box per workflow.
     Each box: size fixed, color red if versions <5, green if >=5."
    | container |
    container := BlElement new.
    container layout: BlLinearLayout horizontal.
    container background: Color white.

    (workflows ifNil: [ #() ]) do: [:wf |
        | box versionCount |
        versionCount := (wf respondsTo: #versions) ifTrue: [ wf versions size ] ifFalse: [ 0 ].
        box := BlElement new.
        box size: 60 @ 60.
        box background: (versionCount < 5 ifTrue: [ Color red ] ifFalse: [ Color green ]).
        box border: (BlBorder paint: Color black width: 1).
        container addChild: box.
    ].

    ^ container

]

{ #category : #accessing }
WorkflowVisualizer >> workflows: aCollection [
    "Store the collection of workflows to visualize"
    workflows := aCollection.

]
