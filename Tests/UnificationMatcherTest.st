TestCase subclass: #UnificationMatcherTest
	instanceVariableNames: 'matcher substitution'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!UnificationMatcherTest methodsFor: 'helpers' stamp: 'fbs 7/28/2011 22:17'!
assert: left equals: right description: msg
	self
		assert: left = right
		description: ('{1} , expected {2}, got {3}' format: {msg. left printString. right printString.}).! !


!UnificationMatcherTest methodsFor: 'running' stamp: 'fbs 10/7/2011 07:44'!
setUp
	matcher := UnificationMatcher matcherUsing:
		{[Leaf value: 1] -> ['first leaf'].
		[Leaf value: 1] -> ['second leaf'].
		[Tree empty] -> ['tree'].
		[TreeNode left: #x asVariable] -> [:mgu | substitution := mgu. 'mgu-using case']}
		otherwise: ['otherwise block'].! !


!UnificationMatcherTest methodsFor: 'testing - matching' stamp: 'fbs 8/8/2011 19:09'!
testFirstMatchWins
	| result |
	result := matcher match: (Leaf value: 1).
	self assert: result = 'first leaf' description: 'Unexpected match invoked'.! !

!UnificationMatcherTest methodsFor: 'testing - matching' stamp: 'fbs 10/7/2011 07:44'!
testMatchPassesUnifierIntoBlock
	| result |
	result := matcher match: (TreeNode left: #y asVariable).
	
	self assert: result = 'mgu-using case' description: 'No match found'.
	self assert: substitution notNil description: 'MGU not passed into block'.
	self assert: (substitution at: #y asVariable) = (#x asVariable) description: 'Unexpected MGU'.! !

!UnificationMatcherTest methodsFor: 'testing - matching' stamp: 'fbs 8/8/2011 20:26'!
testMatchingTriesAllBlocks
	| result |
	result := matcher match: Tree empty.
	self assert: result = 'tree' description: 'Unexpected result'.! !

!UnificationMatcherTest methodsFor: 'testing - matching' stamp: 'fbs 8/8/2011 20:26'!
testNoMatchEvaluatesOtherwiseBlock
	| result |
	result := matcher match: (Leaf value: 2).
	self assert: result = 'otherwise block' description: 'Otherwise block not invoked'.! !

!UnificationMatcherTest methodsFor: 'testing - matching' stamp: 'fbs 7/28/2011 22:28'!
testNoMatchEvaluatesRaisesError
	| m |
	m := UnificationMatcher matcherUsing:
			{[Tree empty] -> ['matched something']}.
			
	self should: [m matchAgainst: (Leaf value: 1)] raise: Error.! !
