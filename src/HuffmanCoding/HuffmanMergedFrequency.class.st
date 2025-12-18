Class {
	#name : 'HuffmanMergedFrequency',
	#superclass : 'HuffmanFrequency',
	#instVars : [
		'left',
		'right'
	],
	#category : 'HuffmanCoding',
	#package : 'HuffmanCoding'
}

{ #category : 'accessing' }
HuffmanMergedFrequency class >> left: anObject right: annotherObject [
	| result |
	result := self new.
	result left: anObject.
	result right: annotherObject.
	anObject parent: result.
	annotherObject parent: result.
	^ result
]

{ #category : 'as yet unclassified' }
HuffmanMergedFrequency >> children [
	^ {left . right}
]

{ #category : 'as yet unclassified' }
HuffmanMergedFrequency >> find: aCharacter [
	| result |
	result := nil.
	self
		traverseDo: [ :each | (each isCharacterFrequency and: [ each character = aCharacter ]) ifTrue: [ result := each ] ].
	^ result
]

{ #category : 'as yet unclassified' }
HuffmanMergedFrequency >> frequency [
	^ left frequency + right frequency
]

{ #category : 'as yet unclassified' }
HuffmanMergedFrequency >> gtDisplayOn: stream [
	stream nextPutAll: (self frequency round: 2) asString
]

{ #category : 'as yet unclassified' }
HuffmanMergedFrequency >> gtTreeFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Frequencies';
		priority: 1;
		items: [ {self} ];
		children: #children;
		column: 'Frequency' text: [ :each | each frequency ];
		column: 'Character' text: [ :each | each isCharacterFrequency ifTrue: [ each character ] ifFalse: [ '' ] ];
		column: 'Code' text: [ :each | each code ];
		expandAll
]

{ #category : 'accessing' }
HuffmanMergedFrequency >> left [
	^ left
]

{ #category : 'accessing' }
HuffmanMergedFrequency >> left: anObject [ 
	left := anObject
]

{ #category : 'accessing' }
HuffmanMergedFrequency >> right [
	^ right
]

{ #category : 'accessing' }
HuffmanMergedFrequency >> right: anObject [ 
	right := anObject
]

{ #category : 'as yet unclassified' }
HuffmanMergedFrequency >> traverseDo: aBlock [ 
	left traverseDo: aBlock.
	aBlock value: self.
	right traverseDo: aBlock
]
