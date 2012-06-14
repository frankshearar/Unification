TestCase subclass: #HeadUnifierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests-Destructuring'!

!HeadUnifierTest methodsFor: 'testing - error reporting' stamp: 'fbs 6/14/2012 09:14'!
testErrorMentionsUnunifiableNodes
	[1 unifyWith: (HeadUnifier named: #y)] on: UnificationFailure do:
		[:e |
		self assert: (e this isKindOf: HeadUnifier).
		self assert: 1 equals: e that].
	
	[(HeadUnifier named: #y) unifyWith: 1] on: UnificationFailure do:
		[:e |
		self assert: (e this isKindOf: HeadUnifier).
		self assert: 1 equals: e that].! !


!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:14'!
testCanUnifyAgainstFirstNWhenLeftOperand
	| mgu |
	mgu := (HeadUnifier values: {#x asVariable. #y asVariable}) unifyWith: #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:14'!
testCanUnifyAgainstFirstNWhenRightOperand
	| mgu |
	mgu := #(1 2 3) unifyWith: (HeadUnifier values: {#x asVariable. #y asVariable}).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:14'!
testCanUnifyAgainstaVariable
	| mgu head |
	mgu := #x asVariable unifyWith: (HeadUnifier named: #y).
	head := mgu at: #x asVariable.
	self assert: #y asVariable equals: head value.! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:14'!
testHeadCantUnifyWithNormalObjects
	self should: [1 unifyWith: (HeadUnifier named: #x)] raise: UnificationFailure.
	self should: [$a unifyWith: (HeadUnifier named: #x)] raise: UnificationFailure.
	self should: [Object new unifyWith: (HeadUnifier named: #x)] raise: UnificationFailure.
	self should: [(HeadUnifier named: #x) unifyWith: 1] raise: UnificationFailure.
	self should: [(HeadUnifier named: #x) unifyWith: $a] raise: UnificationFailure.
	self should: [(HeadUnifier named: #x) unifyWith: Object new] raise: UnificationFailure.! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:14'!
testPipeConstructsaListUnifier
	| list mgu |
	list := (HeadUnifier named: #x) | #y asVariable.
	self assert: ListUnifier equals: list class.
	mgu := list unifyWith: #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:15'!
testUnifyingWithCollectionUnifiesOnFirstElement
	| mgu |
	mgu := (HeadUnifier named: #x) unifyWith: #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:15'!
testUnifyingWithCollectionUnifiesOnFirstElementWhenCollection
	| mgu |
	mgu := (HeadUnifier value: {#x asVariable}) unifyWith: #((1) 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:15'!
testUnifyingWithCollectionUnifiesOnFirstElementWhenRightOperand
	| mgu |
	mgu := #(1 2 3) unifyWith: (HeadUnifier named: #x).
	self assert: 1 equals: (mgu at: #x asVariable).! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:15'!
testUnifyingWithEmptyCollectionFails
	self should: [(HeadUnifier named: #x) unifyWith: #()] raise: UnificationFailure.! !

!HeadUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:15'!
testUnifyingWithEmptyCollectionFailsWhenRightOperand
	self should: [#() unifyWith: (HeadUnifier named: #x)] raise: UnificationFailure.! !
