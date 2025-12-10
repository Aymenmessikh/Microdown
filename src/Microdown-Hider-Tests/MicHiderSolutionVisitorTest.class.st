Class {
	#name : 'MicHiderSolutionVisitorTest',
	#superclass : 'TestCase',
	#instVars : [
		'visitor'
	],
	#category : 'Microdown-Hider-Tests',
	#package : 'Microdown-Hider-Tests'
}

{ #category : 'running' }
MicHiderSolutionVisitorTest >> setUp [
	super setUp.
	visitor := MicHiderSolutionVisitor new
]

{ #category : 'tests' }
MicHiderSolutionVisitorTest >> testChapterNumber [
	visitor chapterNumber: '3'.
	self assert: visitor chapterNumber equals: '3'
]

{ #category : 'tests' }
MicHiderSolutionVisitorTest >> testContentsGeneratesSolution [
	| document |
	visitor chapterNumber: '2'.
	document := MicrodownParser parse: '```exercise&anchor=exfoo
Foo >> bar
my code
````'.
	visitor visit: document.
	self assert: (visitor contents includesSubstring: '*@exfoo@*').
	self assert: (visitor contents includesSubstring: '*@Chap2@*').
	self assert: (visitor contents includesSubstring: 'my code')
]

{ #category : 'tests' }
MicHiderSolutionVisitorTest >> testVisitCodeCollectsExercise [
	| document |
	visitor chapterNumber: '1'.
	document := MicrodownParser parse: '```exercise&anchor=ex1
Foo >> bar
code here
`````'.
	visitor visit: document.
	self assert: visitor exercises size equals: 1
]
