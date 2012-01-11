TestCase subclass: #UnificationOfCollectionsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!UnificationOfCollectionsTest methodsFor: 'testing - error reporting' stamp: 'fbs 1/11/2012 21:26'!
testErrorMentionsUnunifiableNodes
	[{1} =? 1] on: UnificationFailure do:
		[:e |
		self assert: 1 equals: e this.
		self assert: {1} equals: e that].
	
	[1 =? {1}] on: UnificationFailure do:
		[:e |
		self assert: {1} equals: e this.
		self assert: 1 equals: e that].! !


!UnificationOfCollectionsTest methodsFor: 'testing - unification' stamp: 'fbs 1/5/2012 09:26'!
testNormalObjectsDontUnifyWithCollections
	self should: [1 =? #()] raise: UnificationFailure.
	self should: [#() =? 1] raise: UnificationFailure.! !

!UnificationOfCollectionsTest methodsFor: 'testing - unification' stamp: 'fbs 1/5/2012 09:26'!
testUnificationWorksBidirectionally
	| mgu |
	mgu := {#x asVariable. 1.} =? {2. #y asVariable}.
	self assert: 2 equals: (mgu at: #x asVariable).
	self assert: 1 equals: (mgu at: #y asVariable).! !

!UnificationOfCollectionsTest methodsFor: 'testing - unification' stamp: 'fbs 10/7/2011 07:57'!
testUnificationWorksLeftward
	| mgu |
	mgu := {#x asVariable. #y asVariable.} =? #(1 (2 3)).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!UnificationOfCollectionsTest methodsFor: 'testing - unification' stamp: 'fbs 10/7/2011 07:56'!
testUnificationWorksRightward
	| mgu |
	mgu := #(1 (2 3)) =? {#x asVariable. #y asVariable.}.
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !
