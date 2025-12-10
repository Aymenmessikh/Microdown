Class {
	#name : 'MicHiderExtractor',
	#superclass : 'Object',
	#instVars : [
		'sourceFile',
		'chapterNumber'
	],
	#category : 'Microdown-Hider',
	#package : 'Microdown-Hider'
}

{ #category : 'processing files' }
MicHiderExtractor class >> processFile: aFileReference [
	^ self new
		sourceFile: aFileReference;
		process
]

{ #category : 'accessing' }
MicHiderExtractor >> chapterNumber [
	^ chapterNumber
]

{ #category : 'as yet unclassified' }
MicHiderExtractor >> extractChapterNumber [
	| folderName |
	folderName := sourceFile parent basename.
	chapterNumber := folderName select: [:c | c isDigit]
]

{ #category : 'accessing' }
MicHiderExtractor >> process [
	| document studentVisitor solutionVisitor |
	self extractChapterNumber.
	document := MicrodownParser parse: sourceFile contents.
	studentVisitor := MicHiderStudentVisitor new chapterNumber: chapterNumber.
	solutionVisitor := MicHiderSolutionVisitor new chapterNumber: chapterNumber.
	studentVisitor visit: document.
	solutionVisitor visit: document.
	self writeFile: sourceFile basename content: studentVisitor contents.
	self writeFile: (sourceFile basenameWithoutExtension, 'Solutions.md') content: solutionVisitor contents
]

{ #category : 'accessing' }
MicHiderExtractor >> sourceFile: aFileReference [
	sourceFile := aFileReference
]

{ #category : 'writing' }
MicHiderExtractor >> writeFile: filename content: content [
	| targetFile |
	targetFile := sourceFile parent / filename.
	targetFile ensureDelete.
	targetFile writeStreamDo: [:stream | stream nextPutAll: content]
]
