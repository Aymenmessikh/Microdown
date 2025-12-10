Class {
	#name : 'MicHiderStudentVisitorTest',
	#superclass : 'TestCase',
	#instVars : [
		'visitor'
	],
	#category : 'Microdown-Hider-Tests',
	#package : 'Microdown-Hider-Tests'
}

{ #category : 'running' }
MicHiderStudentVisitorTest >> setUp [
	super setUp.
	visitor := MicHiderStudentVisitor new
]

{ #category : 'tests' }
MicHiderStudentVisitorTest >> testChapterNumber [
	visitor chapterNumber: '5'.
	self assert: visitor chapterNumber equals: '5'
]

{ #category : 'tests' }
MicHiderStudentVisitorTest >> testVisitCodeHidesExercise [
	| document |
	visitor chapterNumber: '1'.
	document := MicrodownParser parse: '```exercise&anchor=ex1
Foo >> bar
hidden code
``````'.
	visitor visit: document.
	self assert: (visitor contents includesSubstring: 'Foo >> bar').
	self assert: (visitor contents includesSubstring: '... Your code ...').
	self deny: (visitor contents includesSubstring: 'hidden code')
]

{ #category : 'tests' }
MicHiderStudentVisitorTest >> testVisitRootAddsHeader [
	| document |
	visitor chapterNumber: '1'.
	document := MicrodownParser parse: ''.
	visitor visitRoot: document.
	self assert: (visitor contents includesSubstring: '## Chapt').
	self assert: (visitor contents includesSubstring: '@Chap1')
]
