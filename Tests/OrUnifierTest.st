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


!OrUnifierTest methodsFor: 'test' stamp: 'fbs 10/7/2011 07:45'!
testFirstOptionUnifies
	| mgu |
	mgu := matcher =? (TreeNode left: (Leaf value: 1)).
	self assert: (mgu at: (#x asVariable)) = (Leaf value: 1).! !

!OrUnifierTest methodsFor: 'test' stamp: 'fbs 8/9/2011 07:30'!
testNoUnificationPossibleStillSignalsError
	self should: [matcher =? Tree empty] raise: UnificationFailure! !

!OrUnifierTest methodsFor: 'test' stamp: 'fbs 10/7/2011 07:45'!
testSecondOptionUnifies
	| mgu |
	mgu := matcher =? (TreeNode right: (Leaf value: 1)).
	self assert: (mgu at: (#x asVariable)) = (Leaf value: 1).! !

!OrUnifierTest methodsFor: 'test' stamp: 'fbs 12/28/2011 09:30'!
testUnifiesAsRightHandOperandAgainstFirstOption
	| mgu |
	mgu := (TreeNode left: (Leaf value: 1)) =? matcher.
	self assert: (mgu at: (#x asVariable)) = (Leaf value: 1).! !

!OrUnifierTest methodsFor: 'test' stamp: 'fbs 12/28/2011 09:30'!
testUnifiesAsRightHandOperandAgainstSecondOption
	| mgu |
	mgu := (TreeNode right: (Leaf value: 1)) =? matcher.
	self assert: (mgu at: (#x asVariable)) = (Leaf value: 1).! !
