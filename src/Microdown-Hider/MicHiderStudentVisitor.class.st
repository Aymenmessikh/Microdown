Class {
	#name : 'MicHiderStudentVisitor',
	#superclass : 'MicrodownVisitor',
	#instVars : [
		'builder',
		'chapterNumber',
		'firstHeader'
	],
	#category : 'Microdown-Hider',
	#package : 'Microdown-Hider'
}

{ #category : 'accessing' }
MicHiderStudentVisitor >> chapterNumber [
	^ chapterNumber
]

{ #category : 'accessing' }
MicHiderStudentVisitor >> chapterNumber: aString [
	chapterNumber := aString
]

{ #category : 'accessing' }
MicHiderStudentVisitor >> contents [
	^ builder contents
]

{ #category : 'initialization' }
MicHiderStudentVisitor >> initialize [
	super initialize.
	builder := MicMicrodownTextualBuilder new.
]

{ #category : 'visiting' }
MicHiderStudentVisitor >> visitCode: aCodeBlock [
	(aCodeBlock arguments includesKey: #exercise) ifTrue: [
		builder 
			raw: '```exercise';
			newLine;
			line: (aCodeBlock body lines first trimBoth);
			line: '... Your code ...';
			raw: '```';
			newLine]
]

{ #category : 'visiting' }
MicHiderStudentVisitor >> visitRoot: aRoot [
	builder 
		header: [:b | b text: 'Chapt'] withLevel: 2;
		anchor: 'Chap', chapterNumber;
		newLine.
	self visitChildrenOf: aRoot.
]
