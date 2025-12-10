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
	| document studentVisitor solutionVisitor cleanedContent |
	self extractChapterNumber.
	cleanedContent := self removeIndentationFromCodeBlocks: sourceFile contents.
	document := MicrodownParser parse: cleanedContent.
	studentVisitor := MicHiderStudentVisitor new chapterNumber: chapterNumber.
	solutionVisitor := MicHiderSolutionVisitor new chapterNumber: chapterNumber.
	studentVisitor visit: document.
	solutionVisitor visit: document.
	self writeFile: sourceFile basename content: studentVisitor contents.
	self writeFile: (sourceFile basenameWithoutExtension, 'Solutions.md') content: solutionVisitor contents
]

{ #category : 'removing' }
MicHiderExtractor >> removeIndentationFromCodeBlocks: content [
	| lines result stream trimmed |
	lines := content lines.
	result := String streamContents: [ :aStream |
		stream := aStream.
		lines do: [ :line |
			trimmed := line trimLeft.
			(trimmed beginsWith: '```')
				ifTrue: [ stream nextPutAll: trimmed ]
				ifFalse: [ stream nextPutAll: line ].
			stream cr ] ].
	^ result
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
