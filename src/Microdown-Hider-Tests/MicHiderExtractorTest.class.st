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
MicHiderExtractorTest >> testFullProcess [
	| extractor |
	testFile writeStreamDo: [:s | s nextPutAll: '```exercise&anchor=exfoo
Foo >> bar
some code
```'].
	extractor := MicHiderExtractor new sourceFile: testFile.
	extractor process.
	self assert: (testFile contents includesSubstring: '## Chapt').
	self assert: (testFile contents includesSubstring: 'Foo >> bar').
	self deny: (testFile contents includesSubstring: 'some code').
	self assert: (testFolder / 'File1Solutions.md') exists
]

{ #category : 'tests' }
MicHiderExtractorTest >> testWithIndentedCodeBlock [
	| extractor |
	testFile writeStreamDo: [:s | s nextPutAll: '    ```exercise&anchor=exfoo
Foo >> bar
code
```'].
	extractor := MicHiderExtractor new sourceFile: testFile.
	extractor process.
	self assert: (testFile contents includesSubstring: 'Foo >> bar').
	self assert: (testFolder / 'File1Solutions.md') contents isNotEmpty
]

{ #category : 'tests' }
MicHiderExtractorTest >> testWriteFile [
	| extractor |
	extractor := MicHiderExtractor new sourceFile: testFile.
	extractor writeFile: 'File1.md' content: 'hello'.
	self assert: testFile contents equals: 'hello'
]
