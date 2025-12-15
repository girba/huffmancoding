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

{ #category : 'as yet unclassified' }
HuffmanMergedFrequency >> children [
	^ {left . right}
]

{ #category : 'as yet unclassified' }
HuffmanMergedFrequency >> frequency [
	^ left frequency + right frequency
]

{ #category : 'accessing' }
HuffmanMergedFrequency >> left: anObject [ 
	left := anObject
]

{ #category : 'accessing' }
HuffmanMergedFrequency >> right: anObject [ 
	right := anObject
]
