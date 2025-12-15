Class {
	#name : 'HuffmanCodingExamples',
	#superclass : 'Object',
	#category : 'HuffmanCoding-Examples',
	#package : 'HuffmanCoding',
	#tag : 'Examples'
}

{ #category : 'accessing' }
HuffmanCodingExamples >> englishCharacterFrequencies [
	<gtExample>
	| characterFrequencies coding |
	characterFrequencies := HuffmanCharacterFrequency englishCodingFrequencies
			collect: [ :each | 
				HuffmanCharacterFrequency new
					character: each key;
					frequency: each value * 100 ].
	coding := HuffmanCoding new characterFrequencies: characterFrequencies.
	coding frequencies do: [ :each | each hasParent not ].
	^ coding
]

{ #category : 'accessing' }
HuffmanCodingExamples >> produceFrequencies [
	<gtExample>
	| coding |
	coding := self englishCharacterFrequencies.
	coding run.
	self assert: coding frequencies size equals: 1.
	self assert: coding frequencies first children size equals: 2.
	^ coding
]
