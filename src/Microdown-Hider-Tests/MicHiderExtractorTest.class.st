Class {
	#name : 'MicHiderExtractorTest',
	#superclass : 'TestCase',
	#instVars : [
		'testFolder',
		'testFile'
	],
	#category : 'Microdown-Hider-Tests',
	#package : 'Microdown-Hider-Tests'
}

{ #category : 'running' }
MicHiderExtractorTest >> setUp [
	super setUp.
	testFolder := FileSystem memory / 'Chapter1'.
	testFolder ensureCreateDirectory.
	testFile := testFolder / 'File1.md'
]

{ #category : 'tests' }
MicHiderExtractorTest >> testExtractChapterNumber [
	| extractor |
	extractor := MicHiderExtractor new sourceFile: testFile.
	extractor extractChapterNumber.
	self assert: extractor chapterNumber equals: '1'
]

{ #category : 'tests' }
MicHiderExtractorTest >> testWriteFile [
	| extractor |
	extractor := MicHiderExtractor new sourceFile: testFile.
	extractor writeFile: 'File1.md' content: 'hello'.
	self assert: testFile contents equals: 'hello'
]
