Class {
	#name : 'BaselineOfHuffmanCoding',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfHuffmanCoding',
	#package : 'BaselineOfHuffmanCoding'
}

{ #category : 'loading' }
BaselineOfHuffmanCoding class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'huffmancoding' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : 'baseline' }
BaselineOfHuffmanCoding >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'HuffmanCoding'
		]
]
