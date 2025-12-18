Class {
	#name : 'HuffmanCoding',
	#superclass : 'Object',
	#instVars : [
		'frequencies',
		'merges',
		'serializedSteps'
	],
	#category : 'HuffmanCoding',
	#package : 'HuffmanCoding'
}

{ #category : 'as yet unclassified' }
HuffmanCoding class >> runFor: anArrayOfAssociations [
	| characterFrequencies coding |
	characterFrequencies := anArrayOfAssociations
			collect: [ :each | 
				HuffmanCharacterFrequency new
					character: each key;
					frequency: each value ].
	coding := HuffmanCoding new characterFrequencies: characterFrequencies.
	coding run.
	^ coding
]

{ #category : 'as yet unclassified' }
HuffmanCoding class >> stonAllInstVarNames [
    ^ self allInstVarNames reject: [ :each | each = #serializedSteps ]
]

{ #category : 'accessing' }
HuffmanCoding >> characterFrequencies: aCollection [
	frequencies := aCollection
			asSortedCollection: [ :a :b | a frequency > b frequency ]
]

{ #category : 'as yet unclassified' }
HuffmanCoding >> find: aCharacter [
		self assert: frequencies size = 1 description: 'Finding only makes sense for coded trees. Try using `run` before.'.
	^ self rootFrequency find: aCharacter
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
		column: 'Frequency' text: [ :each | each frequency ];
		column: 'Character'
			text: [ :each | each isCharacterFrequency ifTrue: [ each character ] ifFalse: [ '' ] ];
		column: 'Code' text: [ :each | each code ];
		expandAll
]

{ #category : 'views' }
HuffmanCoding >> gtCodingFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Coding';
		items: [ (self linearizedFrequencies collect: [ :each | each -> each code ]) ];
		column: 'Character' text: [ :each | each key gtDisplayString ];
		column: 'Code' text: [ :each | each value gtDisplayString ];
		send: [ :each | each key ]
]

{ #category : 'views' }
HuffmanCoding >> gtCodingTreeFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Coding tree';
		priority: 10;
		painting: [ :m | self paintCodingTreeHighlightingLastMerge: false with: m ]
]

{ #category : 'views' }
HuffmanCoding >> gtStepsFor: aView [
	<gtView>
	serializedSteps ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Steps';
		items: [ self steps, {self} ];
		itemStencil: [ BlElement new
				layout: BlLinearLayout horizontal;
				margin: (BlInsets all: 3);
				constraintsDo: [ :c | 
					c vertical fitContent.
					c horizontal matchParent ];
				addChild: BlElement new as: #graph ];
		itemDataBinder: [ :anElement :aStep :anIndex | 
			| m |
			m := GtMondrian new.
			aStep paintCodingTreeHighlightingLastMerge: true with: m.
			anElement
				replaceChild: (anElement childNamed: #graph)
				with: m asElement
				as: #graph.
			anElement ]
]

{ #category : 'as yet unclassified' }
HuffmanCoding >> initialize [
	super initialize.
	serializedSteps := OrderedCollection new.
	merges := OrderedCollection new
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
HuffmanCoding >> paintCodingTreeHighlightingLastMerge: aBoolean with: m [
	m nodes
		stencil: [ :each | 
			| container label |
			container := BrVerticalPane new fitContent alignCenter.
			label := BrLabel new
					geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
					border: Color veryVeryLightGray;
					padding: (BlInsets all: 2);
					aptitude: (BrGlamorousLabelAptitude new
							foreground: Color black;
							glamorousRegularSmallSize);
					text: (each frequency round: 2).
			(aBoolean and: [ merges notEmpty and: [ each = merges last ] ])
				ifTrue: [ label background: Color paleRed ].
			(aBoolean and: [ merges notEmpty and: [ merges last children includes: each ] ])
				ifTrue: [ label background: Color lightRed ].
			container addChild: label.
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
HuffmanCoding >> postCopy [
	frequencies := frequencies copy.
	serializedSteps := serializedSteps copy.
	merges := merges copy
]

{ #category : 'as yet unclassified' }
HuffmanCoding >> rootFrequency [
	self assert: frequencies size = 1 description: 'The root only makes sense for coded trees in which frequencies have a single . Try using `run` before.'.
	^ self frequencies anyOne
]

{ #category : 'accessing' }
HuffmanCoding >> run [
	[ frequencies size > 1 ]
		whileTrue: [ | lastTwo merge |
			serializedSteps add: (STON toString: self).
			lastTwo := frequencies last: 2.
			frequencies removeAll: lastTwo.
			merge := HuffmanMergedFrequency left: lastTwo first right: lastTwo last.
			merges add: merge.
			frequencies add: merge ]
]

{ #category : 'as yet unclassified' }
HuffmanCoding >> serializedSteps [
	^ serializedSteps
]

{ #category : 'as yet unclassified' }
HuffmanCoding >> steps [
	^ serializedSteps collect: [:each | STON fromString: each ]
]
