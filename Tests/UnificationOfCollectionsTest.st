TestCase subclass: #UnificationOfCollectionsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!UnificationOfCollectionsTest methodsFor: 'testing - error reporting' stamp: 'fbs 6/14/2012 09:18'!
testErrorMentionsUnunifiableNodes
	[{1} unifyWith: 1] on: UnificationFailure do:
		[:e |
		self assert: 1 equals: e this.
		self assert: {1} equals: e that].
	
	[1 unifyWith: {1}] on: UnificationFailure do:
		[:e |
		self assert: {1} equals: e this.
		self assert: 1 equals: e that].! !


!UnificationOfCollectionsTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:18'!
testNormalObjectsDontUnifyWithCollections
	self should: [1 unifyWith: #()] raise: UnificationFailure.
	self should: [#() unifyWith: 1] raise: UnificationFailure.! !

!UnificationOfCollectionsTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:18'!
testUnificationWorksBidirectionally
	| mgu |
	mgu := {#x asVariable. 1.} unifyWith: {2. #y asVariable}.
	self assert: 2 equals: (mgu at: #x asVariable).
	self assert: 1 equals: (mgu at: #y asVariable).! !

!UnificationOfCollectionsTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:18'!
testUnificationWorksLeftward
	| mgu |
	mgu := {#x asVariable. #y asVariable.} unifyWith: #(1 (2 3)).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!UnificationOfCollectionsTest methodsFor: 'testing - unification' stamp: 'fbs 6/14/2012 09:18'!
testUnificationWorksRightward
	| mgu |
	mgu := #(1 (2 3)) unifyWith: {#x asVariable. #y asVariable.}.
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !
