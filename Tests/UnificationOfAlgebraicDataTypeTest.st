TestCase subclass: #UnificationOfAlgebraicDataTypeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!UnificationOfAlgebraicDataTypeTest methodsFor: 'testing' stamp: 'fbs 1/5/2012 09:29'!
testAlgebraicDataTypeOrReturnsOrMatcher
	| mgu |
	mgu := ((TreeNode left: #x asVariable) or: (TreeNode right: #x asVariable)) =? (TreeNode right: (Leaf value: 1)).
	self assert: (mgu at: (#x asVariable)) = (Leaf value: 1).! !

!UnificationOfAlgebraicDataTypeTest methodsFor: 'testing' stamp: 'fbs 1/5/2012 09:24'!
testDifferentArityTermsShouldNotUnify
	"f(x) ~= g(x,y)"
	|f g |
	f := VariadicTerm with: #(#x).
	g := VariadicTerm with: #(#x #y).
	self should: [f unifyWith: g] raise: UnificationFailure.! !


!UnificationOfAlgebraicDataTypeTest methodsFor: 'testing - collection unification' stamp: 'fbs 1/9/2012 09:34'!
testUnappliedAlgebraicDataTypesCantUnifyWithAlgebraicDataTypes
	self shouldnt: [ (Leaf value: 1) =? #(Leaf 1) ] raise: UnificationFailure.! !

!UnificationOfAlgebraicDataTypeTest methodsFor: 'testing - collection unification' stamp: 'fbs 1/5/2012 09:25'!
testUnificationWithCollectionsWorksBidirectionally
	| mgu |
	mgu := {#x asVariable. 1.} =? {VariadicTerm with: {#a asVariable}. #y asVariable.}.
	self assert: (VariadicTerm with: {#a asVariable}) equals: (mgu at: #x asVariable).
	self assert: 1 equals: (mgu at: #y asVariable).! !
