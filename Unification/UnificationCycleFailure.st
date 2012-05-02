UnificationFailure subclass: #UnificationCycleFailure
	instanceVariableNames: 'cyclicTerm'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!UnificationCycleFailure commentStamp: 'fbs 5/2/2012 09:48' prior: 0!
I represent the failure to unify a cyclic structure, such as x =? {x}.!


!UnificationCycleFailure methodsFor: 'private' stamp: 'fbs 1/11/2012 20:10'!
cycle: anObject
	cyclicTerm := anObject.! !


!UnificationCycleFailure methodsFor: 'accessing' stamp: 'fbs 1/11/2012 20:10'!
cyclicTerm
	^ cyclicTerm.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

UnificationCycleFailure class
	instanceVariableNames: ''!


!UnificationCycleFailure class methodsFor: 'as yet unclassified' stamp: 'fbs 1/11/2012 20:09'!
signalCycleOn: aCyclicTerm
	^ self new
		cycle: aCyclicTerm;
		signal.! !
