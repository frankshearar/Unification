TestCase subclass: #ListUnifierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests-Destructuring'!

!ListUnifierTest methodsFor: 'testing - error reporting' stamp: 'fbs 6/14/2012 09:15'!
testErrorMentionsUnunifiableNodes
	[1 unifyWith: (ListUnifier headNamed: #x tailNamed: #y)] on: UnificationFailure do:
		[:e |
		self assert: (e this isKindOf: ListUnifier).
		self assert: 1 equals: e that].! !


!ListUnifierTest methodsFor: 'testing - instance creation' stamp: 'fbs 6/14/2012 09:15'!
testHeadNamedTailNamedReturnsListUnifier
	| l mgu |
	l := ListUnifier headNamed: #x tailNamed: #y.
	mgu := l unifyWith: #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'testing - instance creation' stamp: 'fbs 6/14/2012 09:15'!
testHeadNamedTailReturnsListUnifier
	| l mgu |
	l := ListUnifier headNamed: #x tail: #(2 3).
	mgu := l unifyWith: #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).! !

!ListUnifierTest methodsFor: 'testing - instance creation' stamp: 'fbs 6/14/2012 09:15'!
testHeadTailNamedReturnsListUnifier
	| l mgu |
	l := ListUnifier head: 1 tailNamed: #x.
	mgu := l unifyWith: #(1 2 3).
	self assert: #(2 3) equals: (mgu at: #x asVariable).! !

!ListUnifierTest methodsFor: 'testing - instance creation' stamp: 'fbs 6/14/2012 09:16'!
testHeadTailReturnsListUnifier
	| l mgu |
	l := ListUnifier head: #x asVariable tail: #y asVariable.
	mgu := l unifyWith: #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !


!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:15'!
testCanAppearOnRightHandSide
	| mgu |
	mgu := #(1 2 3) unifyWith: (ListUnifier headNamed: #x tailNamed: #y).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:15'!
testCanUnifyAgainstaVariable
	| mgu list |
	mgu := #z asVariable unifyWith: (ListUnifier headNamed: #x tailNamed: #y).
	list := mgu at: #z asVariable.
	self assert: #x asVariable equals: list head.
	self assert: #y asVariable equals: list tail.! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:15'!
testCantUnifyWithNormalObjects
	self should: [1 unifyWith: (ListUnifier headNamed: #x tailNamed: #y)] raise: UnificationFailure.
	self should: [$a unifyWith: (ListUnifier headNamed: #x tailNamed: #y)] raise: UnificationFailure.
	self should: [Object new unifyWith: (ListUnifier headNamed: #x tailNamed: #y)] raise: UnificationFailure.
	self should: [(ListUnifier headNamed: #x tailNamed: #y) unifyWith: 1] raise: UnificationFailure.
	self should: [(ListUnifier headNamed: #x tailNamed: #y) unifyWith: $a] raise: UnificationFailure.
	self should: [(ListUnifier headNamed: #x tailNamed: #y) unifyWith: Object new] raise: UnificationFailure.! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:16'!
testUnifyWithCollectionDestructuresIntoHeadAndTail
	| mgu |
	mgu := (ListUnifier headNamed: #x tailNamed: #y) unifyWith: #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:16'!
testUnifyWithCollectionPermitsMultiElementHead
	| mgu |
	"[X, Y | T] = [1, 2, 3] in Prolog"
	mgu := (ListUnifier head: {#x asVariable. #y asVariable} tail: #t asVariable) unifyWith: #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).
	self assert: #(3) equals: (mgu at: #t asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:16'!
testUnifyWithCollectionPermitsMultiElementHeadEvenWithEmptyTail
	| mgu |
	"[X, Y | T] = [1, 2, 3] in Prolog"
	mgu := (ListUnifier head: {#x asVariable. #y asVariable} tail: #t asVariable)
		unifyWith: (OrderedCollection with: 1 with: 2).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).
	self assert: OrderedCollection new equals: (mgu at: #t asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:16'!
testUnifyWithSingleElementCollectionMakesTailEmpty
	| mgu |
	mgu := (ListUnifier headNamed: #x tailNamed: #y) unifyWith: #(1).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #() equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:16'!
testUnifyWithSingleElementCollectionRespectsCollectionType
	| mgu |
	mgu := (ListUnifier headNamed: #x tailNamed: #y) unifyWith: (OrderedCollection with: 1).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: OrderedCollection new equals: (mgu at: #y asVariable).! !

!ListUnifierTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:16'!
testUnifyWithSpecificTail
	| mgu |
	mgu := (ListUnifier headNamed: #x tail: {#y asVariable. #z asVariable}) unifyWith: #(1 2 3).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: 2 equals: (mgu at: #y asVariable).
	self assert: 3 equals: (mgu at: #z asVariable).! !
