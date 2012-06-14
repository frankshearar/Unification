TestCase subclass: #OrUnifierTest
	instanceVariableNames: 'matcher'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!OrUnifierTest methodsFor: 'running' stamp: 'fbs 10/7/2011 07:45'!
setUp
	matcher := OrUnifier
		left: (TreeNode left: #x asVariable)
		right: (TreeNode right: #x asVariable).! !


!OrUnifierTest methodsFor: 'test' stamp: 'fbs 6/14/2012 09:16'!
testFirstOptionUnifies
	| mgu |
	mgu := matcher unifyWith: (TreeNode left: (Leaf value: 1)).
	self assert: (mgu at: (#x asVariable)) = (Leaf value: 1).! !

!OrUnifierTest methodsFor: 'test' stamp: 'fbs 6/14/2012 09:16'!
testNoUnificationPossibleStillSignalsError
	self should: [matcher unifyWith: Tree empty] raise: UnificationFailure! !

!OrUnifierTest methodsFor: 'test' stamp: 'fbs 6/14/2012 09:16'!
testSecondOptionUnifies
	| mgu |
	mgu := matcher unifyWith: (TreeNode right: (Leaf value: 1)).
	self assert: (mgu at: (#x asVariable)) = (Leaf value: 1).! !

!OrUnifierTest methodsFor: 'test' stamp: 'fbs 6/14/2012 09:16'!
testUnifiesAsRightHandOperandAgainstFirstOption
	| mgu |
	mgu := (TreeNode left: (Leaf value: 1)) unifyWith: matcher.
	self assert: (mgu at: (#x asVariable)) = (Leaf value: 1).! !

!OrUnifierTest methodsFor: 'test' stamp: 'fbs 6/14/2012 09:16'!
testUnifiesAsRightHandOperandAgainstSecondOption
	| mgu |
	mgu := (TreeNode right: (Leaf value: 1)) unifyWith: matcher.
	self assert: (mgu at: (#x asVariable)) = (Leaf value: 1).! !
