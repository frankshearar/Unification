Error subclass: #UnificationFailure
	instanceVariableNames: 'this that'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!UnificationFailure commentStamp: 'fbs 1/11/2012 20:36' prior: 0!
I represent the inability to unify two patterns.

Note that in `a =? b`, my this instvar might reference a or b: unification makes no attempt to deterministically assign the left operand to either this or that. (We use double dispatch extensively, and sometimes double-double dispatch, so in general there's no way to correlate the operand handedness to the this or that instvars.)!


!UnificationFailure methodsFor: 'accessing' stamp: 'fbs 1/11/2012 20:34'!
that
	^ that! !

!UnificationFailure methodsFor: 'accessing' stamp: 'fbs 1/11/2012 20:34'!
this
	^ this! !


!UnificationFailure methodsFor: 'private' stamp: 'fbs 1/11/2012 20:33'!
this: thisObject that: thatObject
	this := thisObject.
	that := thatObject.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

UnificationFailure class
	instanceVariableNames: ''!

!UnificationFailure class methodsFor: 'instance creation' stamp: 'fbs 1/11/2012 20:32'!
signalThis: thisObject that: thatObject
	^ self new
		this: thisObject that: thatObject;
		signal.! !
