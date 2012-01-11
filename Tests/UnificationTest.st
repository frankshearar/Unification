TestCase subclass: #UnificationTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/8/2012 22:49'!
testAnythingCanUnifyAgainstMetaVariables
	self shouldnt: ['a' =? #x asVariable] raise: UnificationFailure.
	self shouldnt: [$a =? #x asVariable] raise: UnificationFailure.
	self shouldnt: [1 =? #x asVariable] raise: UnificationFailure.
	self shouldnt: [#() =? #x asVariable] raise: UnificationFailure.
	self shouldnt: [Object new =? #x asVariable] raise: UnificationFailure.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/11/2012 22:09'!
testCyclicStructuresCantUnify
	| y |
	y := MetaVariable named: #y.
	self should: [y unifyWith: {y}] raise: UnificationFailure.
	[y unifyWith: {y}]
		on: UnificationCycleFailure
		do: [:e | self assert: {y} equals: e cyclicTerm].! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 22:16'!
testImpossibleUnificationShouldNotUnify
	self should: [1 unifyWith: 2] raise: UnificationFailure.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/8/2012 22:56'!
testMetaVariablesCanUnifyAgainstAnything
	self shouldnt: [#x asVariable =? 'a'] raise: UnificationFailure.
	self shouldnt: [#x asVariable =? $a] raise: UnificationFailure.
	self shouldnt: [#x asVariable =? 1] raise: UnificationFailure.
	self shouldnt: [#x asVariable =? #()] raise: UnificationFailure.
	self shouldnt: [#x asVariable =? Object new] raise: UnificationFailure.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/29/2011 15:08'!
testSelfUnificationShouldUnify
	| x |
	x := MetaVariable named: #x.
	"Tautologies"
	self assert: (1 unifyWith: 1) isEmpty.
	self assert: (x unifyWith: x) isEmpty.! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 5/26/2011 07:43'!
testTrivialBidirectionalUnificationShouldUnify
	| matches x y |
	x := MetaVariable named: #x.
	y := MetaVariable named: #y.
	matches := x unifyWith: y.
	self assert: matches = (Dictionary newFrom: {x -> y}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 22:18'!
testTrivialUnificationsShouldUnify
	| x |
	x := MetaVariable named: #x.
	self assert: (x unifyWith: 2) = (Dictionary newFrom: {x -> 2}).
	self assert: (2 unifyWith: x) = (Dictionary newFrom: {x -> 2}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 22:22'!
testTwoVariableBidirectionalUnificationShouldUnifyBoth
	| matches left right |
	left := MetaVariable named: #left.
	right := MetaVariable named: #right.
	matches := {left. 2} unifyWith: {1. right}.
	self assert: matches = (Dictionary newFrom: {
		left -> 1.
		right -> 2}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 22:21'!
testTwoVariableUnificationShouldUnifyBoth
	| matches left right |
	left := MetaVariable named: #left.
	right := MetaVariable named: #right.
	matches := {left. right} unifyWith: {1. 2}.
	self assert: matches = (Dictionary newFrom: {
		left -> 1.
		right -> 2}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/5/2012 09:27'!
testUnificationWorksOnDeepStructures
	| matches x y |
	x := MetaVariable named: #x.
	y := MetaVariable named: #y.
	matches := { {{x}} } unifyWith: {y}.
	self assert: matches = (Dictionary newFrom: { y -> {{x}} }).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 22:24'!
testVariableUnifyingAgainstTwoVariables
	| matches x y z |
	x := MetaVariable named: #x.
	y := MetaVariable named: #y.
	z := MetaVariable named: #z.
	matches := {x. x.} unifyWith: {y. z.}.
	self assert: matches = (Dictionary newFrom: {y -> x. z -> x}).! !

!UnificationTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 21:36'!
testVariablesInsideCollectionsUnify
	| matches |
	matches := {1. 2. #x asVariable. 4} =? #(1 2 3 4).
	self assert: matches equals: (Dictionary newFromPairs: {#x asVariable. 3.}).
	
	matches := #(1 2 3 4) =? {1. 2. #x asVariable. 4}.
	self assert: matches equals: (Dictionary newFromPairs: {#x asVariable. 3.}).! !
