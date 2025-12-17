Class {
	#name : 'HuffmanFrequency',
	#superclass : 'Object',
	#instVars : [
		'parent'
	],
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
HuffmanFrequency >> hasParent [
	^ parent notNil
]

{ #category : 'as yet unclassified' }
HuffmanFrequency >> isCharacterFrequency [
	^ false
]

{ #category : 'as yet unclassified' }
HuffmanFrequency >> parent [
	^ parent
]

{ #category : 'accessing' }
HuffmanFrequency >> parent: anObject [
	parent := anObject
]
