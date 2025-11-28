Class {
	#name : #VistaGlobalWorkflows,
	#superclass : #Object,
	#category : #'MineriaRep-Model'
}

{ #category : #'gt - views' }
VistaGlobalWorkflows >> gtVistaGlobalWorkflows: aView [
    <gtView>
    "Muestra una pestaña 'Vista Global' para arrays cuyos elementos son Workflows.
     Se delega la creación visual a la clase VistaGlobal (instancia)."
    (self isEmpty or: [ (self first respondsTo: #versions) not ])
        ifTrue: [ ^ aView empty ].

    ^ aView explicit
        title: 'Vista Global';
        priority: 100;
        stencil: [
            | visualizer |
            visualizer := VistaGlobalWorkflows new.
            visualizer workflows: self.
            visualizer visualizarWorkflows
        ];
        yourself.

]

{ #category : #rendering }
VistaGlobalWorkflows >> visualizarWorkflows [
    "Return a simple container with one box per workflow:
     box color red if versions < 5, green otherwise."
    | container |
    container := BlElement new.
    container layout: BlFlowLayout new.
    container background: Color white.

    (workflows ifNil: [ #() ]) do: [:wf |
        | box versionCount |
        versionCount := (wf respondsTo: #versions) ifTrue: [ wf versions size ] ifFalse: [ 0 ].
        box := BlElement new.
        "Simple fixed-size boxes; change sizeFactor if you want scale"
        box size: 60 @ 60.
        box background: (versionCount < 5 ifTrue: [ Color red ] ifFalse: [ Color green ]).
        box border: (BlBorder paint: Color black width: 1).
        container addChild: box.
    ].

    ^ container

]

{ #category : #accessing }
VistaGlobalWorkflows >> workflows: aCollection [
    "Store the workflows collection to visualize."
    workflows := aCollection.

]
