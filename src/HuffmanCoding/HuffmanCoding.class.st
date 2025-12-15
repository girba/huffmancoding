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
		priority: 1;
		items: [ frequencies ];
		children: #children;
		column: 'Value' text: [ :each | each gtDisplayString ];
		column: 'Frequency' text: [ :each | each frequency ]
]

{ #category : 'views' }
HuffmanCoding >> gtCodingTreeFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Coding tree';
		priority: 10;
		painting: [ :m | 
			self paintCodingTreeWith: m ]
]

{ #category : 'accessing' }
HuffmanCoding >> paintCodingTreeWith: m [
	m nodes
		stencil: [ :each | 
			| container |
			container := BrVerticalPane new fitContent alignCenter.
			container
				addChild: (BrLabel new
						aptitude: (BrGlamorousLabelAptitude new
								foreground: Color lightGray;
								glamorousRegularSmallSize);
						text: (each frequency round: 2)).
			each isCharacterFrequency
				ifTrue: [ container
						addChild: (BrLabel new
								aptitude: BrGlamorousLabelAptitude new;
								text: ((each character printString removePrefix: 'Character') removePrefix: '$')) ].
			container ];
		with: (self frequencies withDeepCollect: #children).
	m edges
		fromCenterBottom;
		toCenterTop;
		stencil: [ BlManhattanLineElement new
				zIndex: 0;
				beVertical;
				border: (BlBorder paint: (Color gray alpha: 0.2) width: 1) ];
		connectToAll: #children.
	m layout tree nodeDistance: 10
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
