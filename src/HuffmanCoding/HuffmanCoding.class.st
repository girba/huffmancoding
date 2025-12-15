Class {
	#name : 'HuffmanCoding',
	#superclass : 'Object',
	#instVars : [
		'frequencies'
	],
	#category : 'HuffmanCoding',
	#package : 'HuffmanCoding'
}

{ #category : 'accessing' }
HuffmanCoding >> characterFrequencies: aCollection [
	frequencies := aCollection
			asSortedCollection: [ :a :b | a frequency > b frequency ]
]

{ #category : 'as yet unclassified' }
HuffmanCoding >> frequencies [
	^ frequencies
]

{ #category : 'views' }
HuffmanCoding >> gtCharacterFrequenciesFor: aView [
	<gtView>
	frequencies ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Frequencies';
		items: [ frequencies ];
		children: #children;
		column: 'Value' text: [ :each | each gtDisplayString ];
		column: 'Frequency' text: [ :each | each frequency ]
]

{ #category : 'accessing' }
HuffmanCoding >> run [
	[frequencies size > 1]
		whileTrue: [ | lastTwo |
			lastTwo := frequencies last: 2.
			frequencies removeAll: lastTwo.
			frequencies add: (HuffmanMergedFrequency new left: lastTwo first; right: lastTwo last).
			 ]
]
