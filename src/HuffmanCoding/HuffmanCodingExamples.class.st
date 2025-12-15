Class {
	#name : 'HuffmanCodingExamples',
	#superclass : 'Object',
	#category : 'HuffmanCoding-Examples',
	#package : 'HuffmanCoding',
	#tag : 'Examples'
}

{ #category : 'accessing' }
HuffmanCodingExamples >> englishCharacterFrequencies [
	<gtExample>
	| characterFrequencies coding |
	characterFrequencies := {$  -> 0.183168.
			$e -> 0.102666.
			$t -> 0.075169.
			$a -> 0.065173.
			$o -> 0.061590.
			$n -> 0.057120.
			$i -> 0.056684.
			$s -> 0.053170.
			$r -> 0.049879.
			$h -> 0.049785.
			$l -> 0.033175.
			$d -> 0.032556.
			$c -> 0.022336.
			$u -> 0.022026.
			$m -> 0.020265.
			$f -> 0.019830.
			$w -> 0.017038.
			$g -> 0.016249.
			$p -> 0.015043.
			$y -> 0.014276.
			$b -> 0.012588.
			$v -> 0.008290.
			$k -> 0.005052.
			$x -> 0.001303.
			$j -> 0.000837.
			$q -> 0.000741.
			$z -> 0.000512.
			$, -> 0.006137.
			$. -> 0.005342.
			$- -> 0.002980.
			$' -> 0.002414.
			$" -> 0.002671.
			$: -> 0.000275.
			$; -> 0.000330.
			$? -> 0.000461.
			$! -> 0.000104.
			$( -> 0.000416.
			$) -> 0.000416}
			collect: [ :each | 
				HuffmanCharacterFrequency new
					character: each key;
					frequency: each value ].
	coding := HuffmanCoding new characterFrequencies: characterFrequencies.
	coding frequencies do: [ :each | each hasParent not ].
	^ coding
]

{ #category : 'accessing' }
HuffmanCodingExamples >> produceFrequencies [
	<gtExample>
	| coding |
	coding := self englishCharacterFrequencies.
	coding run.
	self assert: coding frequencies size equals: 1.
	self assert: coding frequencies first children size equals: 2.
	^ coding
]
