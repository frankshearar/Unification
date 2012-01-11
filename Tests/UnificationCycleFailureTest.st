TestCase subclass: #UnificationCycleFailureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!UnificationCycleFailureTest methodsFor: 'testing - instance creation' stamp: 'fbs 1/11/2012 20:08'!
testSignalCycleOnRaisesException
	self should: [UnificationCycleFailure signalCycleOn: 1] raise: UnificationCycleFailure.! !

!UnificationCycleFailureTest methodsFor: 'testing - instance creation' stamp: 'fbs 1/11/2012 20:08'!
testSignalCycleOnStoresCyclicTerm
	[UnificationCycleFailure signalCycleOn: 1] on: UnificationCycleFailure do:
		[:e | self assert: 1 equals: e cyclicTerm].! !
