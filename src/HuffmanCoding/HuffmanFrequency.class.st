Class {
	#name : 'HuffmanFrequency',
	#superclass : 'Object',
	#category : 'HuffmanCoding',
	#package : 'HuffmanCoding'
}

{ #category : 'as yet unclassified' }
HuffmanFrequency >> children [
	^ {}
]

{ #category : 'as yet unclassified' }
HuffmanFrequency >> frequency [
	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
HuffmanFrequency >> isCharacterFrequency [
	^ false
]
