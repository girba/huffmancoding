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

{ #category : 'as yet unclassified' }
HuffmanCoding >> linearizedFrequencies [
	| linearized |
	self assert: frequencies size = 1 description: 'Linearization only makes sense for coded trees. Try using `run` before.'.
	linearized := OrderedCollection new.
	self rootFrequency traverseDo: [ :frequency | frequency isCharacterFrequency ifTrue: [ linearized add: frequency ] ].
	^ linearized
]

{ #category : 'accessing' }
HuffmanCoding >> paintCodingTreeWith: m [
	m nodes
		stencil: [ :each | 
			| container |
			container := BrVerticalPane new fitContent alignCenter.
			container
				addChild: (BrLabel new
						geometry: (BlRoundedRectangleGeometry cornerRadius: 5 );
						border: Color veryVeryLightGray;
						padding: (BlInsets all: 2);
						aptitude: (BrGlamorousLabelAptitude new
								foreground: Color black;
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
		stencil: [ :parent :fromElement :toElement | 
			BlManhattanLineElement new
				zIndex: 0;
				border: (BlBorder paint: Color veryVeryLightGray width: 1);
				layout: BlFrameLayout new;
				clipChildren: false;
				addChild: (BrLabel new
						constraintsDo: [ :c | 
							c frame horizontal alignCenter.
							c frame vertical alignCenter ];
						aptitude: (BrGlamorousLabelAptitude new
								fontSize: 7;
								foreground: Color veryLightGray;
								highlight: Color white);
						text: (parent left = toElement graph model ifTrue: [ '0' ] ifFalse: [ '1' ]));
				beVertical ];
		connectToAll: #children.
	m layout tree nodeDistance: 10
]

{ #category : 'as yet unclassified' }
HuffmanCoding >> rootFrequency [
	self assert: frequencies size = 1 description: 'The root only makes sense for coded trees in which frequencies have a single . Try using `run` before.'.
	^ self frequencies anyOne
]

{ #category : 'accessing' }
HuffmanCoding >> run [
	[ frequencies size > 1 ]
		whileTrue: [ | lastTwo |
			lastTwo := frequencies last: 2.
			frequencies removeAll: lastTwo.
			frequencies
				add: (HuffmanMergedFrequency
						left: lastTwo last
						right: lastTwo first) ]
]
