Class {
	#name : 'HuffmanCodingExamples',
	#superclass : 'Object',
	#category : 'HuffmanCoding-Examples',
	#package : 'HuffmanCoding',
	#tag : 'Examples'
}

{ #category : 'accessing' }
HuffmanCodingExamples >> basicCharacterFrequencies [
	<gtExample>
	| characterFrequencies coding |
	characterFrequencies := {$E -> 2.
			$I -> 3.
			$N -> 1.
			$T -> 3.
			$R -> 2.
			$  -> 1.
			$F -> 1}
			collect: [ :each | 
				HuffmanCharacterFrequency new
					character: each key;
					frequency: each value ].
	coding := HuffmanCoding new characterFrequencies: characterFrequencies.
	coding frequencies do: [ :each | self assert: each hasParent not ].
	^ coding
]

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
HuffmanCodingExamples >> findCharacter [
	<gtExample>
	| coding space |
	coding := self runCoding.
	space := coding find: Character space.
	self assert: space character equals: Character space.
	self assert: space frequency equals: 1.
	self assert: space code equals: '011'.
	^ space
]

{ #category : 'accessing' }
HuffmanCodingExamples >> linearizeFrequencies [
	<gtExample>
	| coding |
	coding := self runCoding.
	self assert: coding linearizedFrequencies size = 7.
	^ coding linearizedFrequencies
]

{ #category : 'accessing' }
HuffmanCodingExamples >> runCoding [
	<gtExample>
	| coding |
	coding := self basicCharacterFrequencies.
	coding run.
	self assert: coding frequencies size equals: 1.
	self assert: coding frequencies first children size equals: 2.
	self assert: coding frequencies first hasParent not.
	self assert: coding frequencies first children first parent = coding frequencies first.
	self assert: coding frequencies first children last parent = coding frequencies first.
	^ coding
]

{ #category : 'accessing' }
HuffmanCodingExamples >> runCodingForEnglish [
	<gtExample>
	| coding |
	coding := self englishCharacterFrequencies.
	coding run.
	self assert: coding frequencies size equals: 1.
	self assert: coding frequencies first children size equals: 2.
	self assert: coding frequencies first hasParent not.
	self assert: coding frequencies first children first parent = coding frequencies first.
	self assert: coding frequencies first children last parent = coding frequencies first.
	^ coding
]

{ #category : 'accessing' }
HuffmanCodingExamples >> runCodingStepsAreNotSerialized [
	<gtExample>
	| coding |
	coding := self runCoding.
	self assert: coding steps size equals: 6.
	coding steps do: [:each | self assert: each serializedSteps isEmpty ].
	^ coding
]
