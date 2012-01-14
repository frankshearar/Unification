TestCase subclass: #ListUnifierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests-Destructuring'!

!ListUnifierTest methodsFor: 'testing - error reporting' stamp: 'fbs 1/11/2012 22:02'!
testErrorMentionsUnunifiableNodes
	[1 =? (ListUnifier headNamed: #x tailNamed: #y)] on: UnificationFailure do:
		[:e |
		self assert: (e this isKindOf: ListUnifier).
		self assert: 1 equals: e that].! !


!ListUnifierTest methodsFor: 'testing - instance creation' stamp: 'fbs 1/11/2012 19:01'!
testHeadNamedTailNamedReturnsListUnifier
	| l mgu |
	l := ListUnifier headNamed: #x tailNamed: #y.
	mgu := l =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'testing - instance creation' stamp: 'fbs 1/11/2012 19:01'!
testHeadNamedTailReturnsListUnifier
	| l mgu |
	l := ListUnifier headNamed: #x tail: #(2 3).
	mgu := l =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).! !

!ListUnifierTest methodsFor: 'testing - instance creation' stamp: 'fbs 1/11/2012 19:02'!
testHeadTailNamedReturnsListUnifier
	| l mgu |
	l := ListUnifier head: 1 tailNamed: #x.
	mgu := l =? #(1 2 3).
	self assert: #(2 3) equals: (mgu at: #x asVariable).! !

!ListUnifierTest methodsFor: 'testing - instance creation' stamp: 'fbs 1/11/2012 19:00'!
testHeadTailReturnsListUnifier
	| l mgu |
	l := ListUnifier head: #x asVariable tail: #y asVariable.
	mgu := l =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !


!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/14/2012 15:23'!
testCanAppearOnRightHandSide
	| mgu |
	mgu := #(1 2 3) =? (ListUnifier headNamed: #x tailNamed: #y).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/14/2012 20:36'!
testCanUnifyAgainstaVariable
	| mgu list |
	mgu := #z asVariable =? (ListUnifier headNamed: #x tailNamed: #y).
	list := mgu at: #z asVariable.
	self assert: #x asVariable equals: list head.
	self assert: #y asVariable equals: list tail.! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/10/2012 09:27'!
testCantUnifyWithNormalObjects
	self should: [1 =? (ListUnifier headNamed: #x tailNamed: #y)] raise: UnificationFailure.
	self should: [$a =? (ListUnifier headNamed: #x tailNamed: #y)] raise: UnificationFailure.
	self should: [Object new =? (ListUnifier headNamed: #x tailNamed: #y)] raise: UnificationFailure.
	self should: [(ListUnifier headNamed: #x tailNamed: #y) =? 1] raise: UnificationFailure.
	self should: [(ListUnifier headNamed: #x tailNamed: #y) =? $a] raise: UnificationFailure.
	self should: [(ListUnifier headNamed: #x tailNamed: #y) =? Object new] raise: UnificationFailure.! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/10/2012 09:36'!
testUnifyWithCollectionDestructuresIntoHeadAndTail
	| mgu |
	mgu := (ListUnifier headNamed: #x tailNamed: #y) =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/11/2012 09:24'!
testUnifyWithCollectionPermitsMultiElementHead
	| mgu |
	"[X, Y | T] = [1, 2, 3] in Prolog"
	mgu := (ListUnifier head: {#x asVariable. #y asVariable} tail: #t asVariable) =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).
	self assert: #(3) equals: (mgu at: #t asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/11/2012 09:44'!
testUnifyWithCollectionPermitsMultiElementHeadEvenWithEmptyTail
	| mgu |
	"[X, Y | T] = [1, 2, 3] in Prolog"
	mgu := (ListUnifier head: {#x asVariable. #y asVariable} tail: #t asVariable)
		=? (OrderedCollection with: 1 with: 2).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).
	self assert: OrderedCollection new equals: (mgu at: #t asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/10/2012 19:02'!
testUnifyWithSingleElementCollectionMakesTailEmpty
	| mgu |
	mgu := (ListUnifier headNamed: #x tailNamed: #y) =? #(1).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #() equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/10/2012 19:02'!
testUnifyWithSingleElementCollectionRespectsCollectionType
	| mgu |
	mgu := (ListUnifier headNamed: #x tailNamed: #y) =? (OrderedCollection with: 1).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: OrderedCollection new equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 1/11/2012 21:59'!
testUnifyWithSpecificTail
	| mgu |
	mgu := (ListUnifier headNamed: #x tail: {#y asVariable. #z asVariable}) =? #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).
	self assert: 3 equals: (mgu at: #z asVariable).! !
