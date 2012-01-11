TestCase subclass: #UnificationFailureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!


!UnificationFailureTest methodsFor: 'testing - instance creation' stamp: 'fbs 1/11/2012 20:38'!
testFailToUnifyWithRaisesException
	[1 failToUnifyWith: 2]
		on: UnificationFailure do: [ :e |
			self assert: 1 equals: e this.
			self assert: 2 equals: e that].! !

!UnificationFailureTest methodsFor: 'testing - instance creation' stamp: 'fbs 1/11/2012 20:39'!
testSignalContainsUnunifiableObjects
	[UnificationFailure signalThis: 1 that: 2]
		on: UnificationFailure do: [ :e |
			self assert: 1 equals: e this.
			self assert: 2 equals: e that].! !

!UnificationFailureTest methodsFor: 'testing - instance creation' stamp: 'fbs 1/11/2012 20:33'!
testSignalLeftRightRaisesException
	self should: [UnificationFailure signalThis: 1 that: 2] raise: UnificationFailure.! !
