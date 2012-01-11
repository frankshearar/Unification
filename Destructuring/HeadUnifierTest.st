TestCase subclass: #HeadUnifierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests-Destructuring'!

!HeadUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:45'!
testHeadCantUnifyWithNormalObjects
	self should: [1 =? (HeadUnifier named: #x)] raise: UnificationFailure.
	self should: [$a =? (HeadUnifier named: #x)] raise: UnificationFailure.
	self should: [Object new =? (HeadUnifier named: #x)] raise: UnificationFailure.
	self should: [(HeadUnifier named: #x) =? 1] raise: UnificationFailure.
	self should: [(HeadUnifier named: #x) =? $a] raise: UnificationFailure.
	self should: [(HeadUnifier named: #x) =? Object new] raise: UnificationFailure.! !

!HeadUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:45'!
testPipeConstructsaListUnifier
	| list |
	list := (HeadUnifier named: #x) | (TailUnifier named: #y).
	self assert: ListUnifier equals: list class.! !

!HeadUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:45'!
testUnifyingWithCollectionUnifiesOnFirstElement
	| mgu |
	mgu := (HeadUnifier named: #x) =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).! !

!HeadUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:45'!
testUnifyingWithCollectionUnifiesOnFirstElementWhenRightOperand
	| mgu |
	mgu := #(1 2 3) =? (HeadUnifier named: #x).
	self assert: 1 equals: (mgu at: #x asVariable).! !

!HeadUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:45'!
testUnifyingWithEmptyCollectionFails
	self should: [(HeadUnifier named: #x) =? #()] raise: UnificationFailure.! !

!HeadUnifierTest methodsFor: 'testing' stamp: 'fbs 1/10/2012 09:45'!
testUnifyingWithEmptyCollectionFailsWhenRightOperand
	self should: [#() =? (HeadUnifier named: #x)] raise: UnificationFailure.! !
