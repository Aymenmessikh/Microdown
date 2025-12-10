Class {
	#name : 'MicHiderSolutionVisitor',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'builder',
		'chapterNumber',
		'exercises'
	],
	#category : 'Microdown-Hider',
	#package : 'Microdown-Hider'
}

{ #category : 'accessing' }
MicHiderSolutionVisitor >> chapterNumber [
	^ chapterNumber
]

{ #category : 'accessing' }
MicHiderSolutionVisitor >> chapterNumber: aString [
	chapterNumber := aString
]

{ #category : 'accessing' }
MicHiderSolutionVisitor >> contents [
	exercises do: [:ex | self writeSolution: ex].
	^ builder contents
]

{ #category : 'accessing' }
MicHiderSolutionVisitor >> exercises [
	^ exercises
]

{ #category : 'initialization' }
MicHiderSolutionVisitor >> initialize [
	super initialize.
	builder := MicMicrodownTextualBuilder new.
	exercises := OrderedCollection new
]

{ #category : 'visiting' }
MicHiderSolutionVisitor >> visitCode: aCodeBlock [
	| anchor |
	(aCodeBlock arguments includesKey: #exercise) ifFalse: [ ^ self ].
	anchor := aCodeBlock anchor.
	anchor ifNotNil: [
			exercises add: {
					anchor.
					aCodeBlock body } ]
]

{ #category : 'writing' }
MicHiderSolutionVisitor >> writeSolution: exercise [
	| anchor code |
	anchor := exercise first.
	code := exercise second.
	builder 
		line: 'Here is the solution of the code *@', anchor, '@* in Chapter *@Chap', chapterNumber, '@*';
		raw: '```';
		newLine;
		newLine;
		rawLines: code;
		newLine;
		raw: '```';
		newLine
]
