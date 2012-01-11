TestCase subclass: #ListUnifierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests-Destructuring'!


!ListUnifierTest methodsFor: 'extensions' stamp: 'fbs 1/10/2012 09:27'!
testCantUnifyWithNormalObjects
	self should: [1 =? (ListUnifier headNamed: #x tailNamed: #y)] raise: UnificationFailure.
	self should: [$a =? (ListUnifier headNamed: #x tailNamed: #y)] raise: UnificationFailure.
	self should: [Object new =? (ListUnifier headNamed: #x tailNamed: #y)] raise: UnificationFailure.
	self should: [(ListUnifier headNamed: #x tailNamed: #y) =? 1] raise: UnificationFailure.
	self should: [(ListUnifier headNamed: #x tailNamed: #y) =? $a] raise: UnificationFailure.
	self should: [(ListUnifier headNamed: #x tailNamed: #y) =? Object new] raise: UnificationFailure.! !

!ListUnifierTest methodsFor: 'extensions' stamp: 'fbs 1/10/2012 09:36'!
testUnifyWithCollectionDestructuresIntoHeadAndTail
	| mgu |
	mgu := (ListUnifier headNamed: #x tailNamed: #y) =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'extensions' stamp: 'fbs 1/11/2012 09:24'!
testUnifyWithCollectionPermitsMultiElementHead
	| mgu |
	"[X, Y | T] = [1, 2, 3] in Prolog"
	mgu := (ListUnifier head: {#x asVariable. #y asVariable} tail: #t asVariable) =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).
	self assert: #(3) equals: (mgu at: #t asVariable).! !

!ListUnifierTest methodsFor: 'extensions' stamp: 'fbs 1/11/2012 09:44'!
testUnifyWithCollectionPermitsMultiElementHeadEvenWithEmptyTail
	| mgu |
	"[X, Y | T] = [1, 2, 3] in Prolog"
	mgu := (ListUnifier head: {#x asVariable. #y asVariable} tail: #t asVariable)
		=? (OrderedCollection with: 1 with: 2).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).
	self assert: OrderedCollection new equals: (mgu at: #t asVariable).! !

!ListUnifierTest methodsFor: 'extensions' stamp: 'fbs 1/10/2012 19:02'!
testUnifyWithSingleElementCollectionMakesTailEmpty
	| mgu |
	mgu := (ListUnifier headNamed: #x tailNamed: #y) =? #(1).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #() equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'extensions' stamp: 'fbs 1/10/2012 19:02'!
testUnifyWithSingleElementCollectionRespectsCollectionType
	| mgu |
	mgu := (ListUnifier headNamed: #x tailNamed: #y) =? (OrderedCollection with: 1).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: OrderedCollection new equals: (mgu at: #y asVariable).! !
