UnificationFailure subclass: #UnificationCycleFailure
	instanceVariableNames: 'cyclicTerm'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!

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
