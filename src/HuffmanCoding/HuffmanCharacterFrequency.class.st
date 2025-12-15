Class {
	#name : 'HuffmanCharacterFrequency',
	#superclass : 'HuffmanFrequency',
	#instVars : [
		'character',
		'frequency',
		'parent'
	],
	#category : 'HuffmanCoding',
	#package : 'HuffmanCoding'
}

{ #category : 'accessing' }
HuffmanCharacterFrequency >> character [
	^ character
]

{ #category : 'accessing' }
HuffmanCharacterFrequency >> character: anObject [ 
	character := anObject
]

{ #category : 'accessing' }
HuffmanCharacterFrequency >> frequency [
	^ frequency
]

{ #category : 'accessing' }
HuffmanCharacterFrequency >> frequency: aNumber [ 
	frequency := aNumber
]

{ #category : 'as yet unclassified' }
HuffmanCharacterFrequency >> gtDisplayOn: aStream [
	character gtDisplayOn: aStream.
	aStream
		space;
		nextPutAll: self frequency asString
]

{ #category : 'as yet unclassified' }
HuffmanCharacterFrequency >> hasParent [
	^ parent notNil
]
