TestCase subclass: #TailUnifierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests-Destructuring'!


!TailUnifierTest methodsFor: 'testing - error reporting' stamp: 'fbs 6/14/2012 09:17'!
testErrorMentionsUnunifiableNodes
	[1 unifyWith: (TailUnifier named: #y)] on: UnificationFailure do:
		[:e |
		self assert: (e this isKindOf: TailUnifier).
		self assert: 1 equals: e that].! !


!TailUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:16'!
testCanUnifyAgainstaVariable
	| mgu tail |
	mgu := #x asVariable unifyWith: (TailUnifier named: #y).
	tail := mgu at: #x asVariable.
	self assert: #y asVariable equals: tail value.! !

!TailUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:17'!
testTailCantUnifyWithNormalObjects
	self should: [1 unifyWith: (TailUnifier named: #x)] raise: UnificationFailure.
	self should: [$a unifyWith: (TailUnifier named: #x)] raise: UnificationFailure.
	self should: [Object new unifyWith: (TailUnifier named: #x)] raise: UnificationFailure.
	self should: [(TailUnifier named: #x) unifyWith: 1] raise: UnificationFailure.
	self should: [(TailUnifier named: #x) unifyWith: $a] raise: UnificationFailure.
	self should: [(TailUnifier named: #x) unifyWith: Object new] raise: UnificationFailure.! !

!TailUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:17'!
testUnifyingWithCollectionUnifiesOnAllButFirstElements
	| mgu |
	mgu := (TailUnifier named: #x) unifyWith: #(1 2 3).
	self assert: #(2 3) equals: (mgu at: #x asVariable).! !

!TailUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:17'!
testUnifyingWithCollectionUnifiesOnAllButFirstElementsWhenRightOperand
	| mgu |
	mgu := #(1 2 3) unifyWith: (TailUnifier named: #x).
	self assert: #(2 3) equals: (mgu at: #x asVariable).! !

!TailUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:17'!
testUnifyingWithEmptyCollectionFails
	self should: [(TailUnifier named: #x) unifyWith: #()] raise: UnificationFailure.! !

!TailUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:17'!
testUnifyingWithEmptyCollectionFailsWhenRightOperand
	self should: [#() unifyWith: (TailUnifier named: #x)] raise: UnificationFailure.! !
