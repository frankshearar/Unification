TestCase subclass: #UnificationOfCollectionsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!UnificationOfCollectionsTest methodsFor: 'testing' stamp: 'fbs 1/5/2012 09:26'!
testNormalObjectsDontUnifyWithCollections
	self should: [1 =? #()] raise: UnificationFailure.
	self should: [#() =? 1] raise: UnificationFailure.! !

!UnificationOfCollectionsTest methodsFor: 'testing' stamp: 'fbs 1/5/2012 09:26'!
testUnificationWorksBidirectionally
	| mgu |
	mgu := {#x asVariable. 1.} =? {2. #y asVariable}.
	self assert: 2 equals: (mgu at: #x asVariable).
	self assert: 1 equals: (mgu at: #y asVariable).! !

!UnificationOfCollectionsTest methodsFor: 'testing' stamp: 'fbs 10/7/2011 07:57'!
testUnificationWorksLeftward
	| mgu |
	mgu := {#x asVariable. #y asVariable.} =? #(1 (2 3)).
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !

!UnificationOfCollectionsTest methodsFor: 'testing' stamp: 'fbs 10/7/2011 07:56'!
testUnificationWorksRightward
	| mgu |
	mgu := #(1 (2 3)) =? {#x asVariable. #y asVariable.}.
	self assert: 1 equals: (mgu at: #x asVariable).
	self assert: #(2 3) equals: (mgu at: #y asVariable).! !
