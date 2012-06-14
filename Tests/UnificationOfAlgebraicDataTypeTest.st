TestCase subclass: #UnificationOfAlgebraicDataTypeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!UnificationOfAlgebraicDataTypeTest methodsFor: 'testing - collection unification' stamp: 'fbs 6/14/2012 09:17'!
testUnappliedAlgebraicDataTypesCantUnifyWithAlgebraicDataTypes
	self shouldnt: [ (Leaf value: 1) unifyWith: #(Leaf 1) ] raise: UnificationFailure.! !

!UnificationOfAlgebraicDataTypeTest methodsFor: 'testing - collection unification' stamp: 'fbs 6/14/2012 09:17'!
testUnificationWithCollectionsWorksBidirectionally
	| mgu |
	mgu := {#x asVariable. 1.} unifyWith: {VariadicTerm with: {#a asVariable}. #y asVariable.}.
	self assert: (VariadicTerm with: {#a asVariable}) equals: (mgu at: #x asVariable).
	self assert: 1 equals: (mgu at: #y asVariable).! !


!UnificationOfAlgebraicDataTypeTest methodsFor: 'testing - error reporting' stamp: 'fbs 6/14/2012 09:17'!
testErrorMentionsUnunifiableNodes
	[1 unifyWith: (Leaf value: 1)] on: UnificationFailure do:
		[:e |
		self assert: (Leaf value: 1) equals: e this.
		self assert: 1 equals: e that].
	
	[(Leaf value: 1) unifyWith: 1] on: UnificationFailure do:
		[:e |
		self assert: 1 equals: e this.
		self assert: (Leaf value: 1) equals: e that].! !


!UnificationOfAlgebraicDataTypeTest methodsFor: 'testing - extensions' stamp: 'fbs 6/14/2012 09:17'!
testAlgebraicDataTypeOrReturnsOrMatcher
	| mgu |
	mgu := ((TreeNode left: #x asVariable) or: (TreeNode right: #x asVariable)) unifyWith: (TreeNode right: (Leaf value: 1)).
	self assert: (mgu at: (#x asVariable)) = (Leaf value: 1).! !


!UnificationOfAlgebraicDataTypeTest methodsFor: 'testing - unification' stamp: 'fbs 1/5/2012 09:24'!
testDifferentArityTermsShouldNotUnify
	"f(x) ~= g(x,y)"
	|f g |
	f := VariadicTerm with: #(#x).
	g := VariadicTerm with: #(#x #y).
	self should: [f unifyWith: g] raise: UnificationFailure.! !
