TestCase subclass: #TailUnifierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests-Destructuring'!

!TailUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:44'!
testTailCantUnifyWithNormalObjects
	self should: [1 =? (TailUnifier named: #x)] raise: UnificationFailure.
	self should: [$a =? (TailUnifier named: #x)] raise: UnificationFailure.
	self should: [Object new =? (TailUnifier named: #x)] raise: UnificationFailure.
	self should: [(TailUnifier named: #x) =? 1] raise: UnificationFailure.
	self should: [(TailUnifier named: #x) =? $a] raise: UnificationFailure.
	self should: [(TailUnifier named: #x) =? Object new] raise: UnificationFailure.! !

!TailUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:44'!
testUnifyingWithCollectionUnifiesOnAllButFirstElements
	| mgu |
	mgu := (TailUnifier named: #x) =? #(1 2 3).
	self assert: #(2 3) equals: (mgu at: #x asVariable).! !

!TailUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:44'!
testUnifyingWithCollectionUnifiesOnAllButFirstElementsWhenRightOperand
	| mgu |
	mgu := #(1 2 3) =? (TailUnifier named: #x).
	self assert: #(2 3) equals: (mgu at: #x asVariable).! !

!TailUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:44'!
testUnifyingWithEmptyCollectionFails
	self should: [(TailUnifier named: #x) =? #()] raise: UnificationFailure.! !

!TailUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:44'!
testUnifyingWithEmptyCollectionFailsWhenRightOperand
	self should: [#() =? (TailUnifier named: #x)] raise: UnificationFailure.! !
