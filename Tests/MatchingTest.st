TestCase subclass: #MatchingTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!MatchingTest methodsFor: 'helpers' stamp: 'fbs 7/22/2011 07:55'!
assert: left equals: right description: msg
	self
		assert: left = right
		description: ('{1} , expected {2}, got {3}' format: {msg. left printString. right printString.}).! !


!MatchingTest methodsFor: 'testing - matching' stamp: 'fbs 7/28/2011 14:18'!
testEmptyMguPassedIntoValueBlockMatchWins
	| result substitution |
	result := 1 matchOneOf: {[1] -> [:mgu | substitution := mgu. 'foo']} otherwise: ['bar'].
	self assert: result = 'foo'.
	self assert: substitution isEmpty.! !

!MatchingTest methodsFor: 'testing - matching' stamp: 'fbs 1/5/2012 09:34'!
testFirstMatchWins
	| result |
	result := 1
		matchOneOf:
			{[1] -> ['first match'].
			[1] -> ['second match'].}
		otherwise: ['otherwise block'].
	self assert: result = 'first match' description: 'Unexpected match invoked'.! !

!MatchingTest methodsFor: 'testing - matching' stamp: 'fbs 1/5/2012 09:35'!
testMatchPassesUnifierIntoBlock
	| result mgu |
	result := {1}
		matchOneOf:
			{[{#x asVariable}] -> [:vars | mgu := vars. 'match']}
		otherwise: ['otherwise block'].
	self assert: result = 'match' description: 'No match found'.
	self assert: mgu notNil description: 'MGU not passed into block'.
	self assert: (mgu at: #x asVariable) = 1 description: 'Unexpected MGU'.! !

!MatchingTest methodsFor: 'testing - matching' stamp: 'fbs 1/5/2012 09:36'!
testMatchingTriesAllBlocks
	| result |
	result := 1
		matchOneOf:
			{[0] -> ['first match'].
			[1] -> ['second match'].}
		otherwise: ['otherwise block'].
	self assert: result = 'second match' description: 'Unexpected result'.! !

!MatchingTest methodsFor: 'testing - matching' stamp: 'fbs 1/5/2012 09:32'!
testMatchingUnifiesBidirectionally
	| result mgu |
	result := {#x asVariable. 1}
		matchOneOf:
			{[{2. #y asVariable}] -> [:vars | mgu := vars. 'match']}
		otherwise: ['otherwise block'].
	self assert: result = 'match' description: 'No match found'.
	self assert: mgu notNil description: 'MGU not passed into block'.
	self assert: (mgu at: #x asVariable) equals: 2 description: 'Unexpected MGU (x)'.
	self assert: (mgu at: #y asVariable) equals: 1 description: 'Unexpected MGU (y)'.! !

!MatchingTest methodsFor: 'testing - matching' stamp: 'fbs 1/5/2012 09:33'!
testNoMatchEvaluatesOtherwiseBlock
	| result |
	result := 1
		matchOneOf:
			{['not a 1'] -> ['matched something']}
		otherwise: ['otherwise block'].
	self assert: result = 'otherwise block' description: 'Otherwise block not invoked'.! !

!MatchingTest methodsFor: 'testing - matching' stamp: 'fbs 1/5/2012 09:33'!
testNoMatchEvaluatesRaisesError
	self should: [1
		matchOneOf:
			{['not a 1'] -> ['matched something']}]
		raise: Error.! !
