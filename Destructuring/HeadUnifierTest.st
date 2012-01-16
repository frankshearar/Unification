TestCase subclass: #HeadUnifierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests-Destructuring'!

!HeadUnifierTest methodsFor: 'testing - error reporting' stamp: 'fbs 1/11/2012 21:41'!
testErrorMentionsUnunifiableNodes
	[1 =? (HeadUnifier named: #y)] on: UnificationFailure do:
		[:e |
		self assert: (e this isKindOf: HeadUnifier).
		self assert: 1 equals: e that].
	
	[(HeadUnifier named: #y) =? 1] on: UnificationFailure do:
		[:e |
		self assert: (e this isKindOf: HeadUnifier).
		self assert: 1 equals: e that].! !


!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/11/2012 14:03'!
testCanUnifyAgainstFirstNWhenLeftOperand
	| mgu |
	mgu := (HeadUnifier values: {#x asVariable. #y asVariable}) =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/11/2012 14:03'!
testCanUnifyAgainstFirstNWhenRightOperand
	| mgu |
	mgu := #(1 2 3) =? (HeadUnifier values: {#x asVariable. #y asVariable}).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/14/2012 21:10'!
testCanUnifyAgainstaVariable
	| mgu head |
	mgu := #x asVariable =? (HeadUnifier named: #y).
	head := mgu at: #x asVariable.
	self assert: #y asVariable equals: head value.! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/10/2012 09:45'!
testHeadCantUnifyWithNormalObjects
	self should: [1 =? (HeadUnifier named: #x)] raise: UnificationFailure.
	self should: [$a =? (HeadUnifier named: #x)] raise: UnificationFailure.
	self should: [Object new =? (HeadUnifier named: #x)] raise: UnificationFailure.
	self should: [(HeadUnifier named: #x) =? 1] raise: UnificationFailure.
	self should: [(HeadUnifier named: #x) =? $a] raise: UnificationFailure.
	self should: [(HeadUnifier named: #x) =? Object new] raise: UnificationFailure.! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/16/2012 16:42'!
testPipeConstructsaListUnifier
	| list mgu |
	list := (HeadUnifier named: #x) | #y asVariable.
	self assert: ListUnifier equals: list class.
	mgu := list =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/10/2012 09:45'!
testUnifyingWithCollectionUnifiesOnFirstElement
	| mgu |
	mgu := (HeadUnifier named: #x) =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/11/2012 13:59'!
testUnifyingWithCollectionUnifiesOnFirstElementWhenCollection
	| mgu |
	mgu := (HeadUnifier value: {#x asVariable}) =? #((1) 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/10/2012 09:45'!
testUnifyingWithCollectionUnifiesOnFirstElementWhenRightOperand
	| mgu |
	mgu := #(1 2 3) =? (HeadUnifier named: #x).
	self assert: 1 equals: (mgu at: #x asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/10/2012 09:45'!
testUnifyingWithEmptyCollectionFails
	self should: [(HeadUnifier named: #x) =? #()] raise: UnificationFailure.! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/10/2012 09:45'!
testUnifyingWithEmptyCollectionFailsWhenRightOperand
	self should: [#() =? (HeadUnifier named: #x)] raise: UnificationFailure.! !
