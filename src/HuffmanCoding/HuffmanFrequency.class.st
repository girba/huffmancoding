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

{ #category : 'accessing' }
HuffmanFrequency >> code [
	| code |
	code := ''.
	self
		deep: [ :each | each parent ]
		do: [ :p |  ]
		relationDo: [ :child :p | code := code , (p left = child ifTrue: [ '0' ] ifFalse: [ '1' ]) ].
	^ code reverse
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
