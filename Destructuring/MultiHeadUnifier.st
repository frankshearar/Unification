HeadUnifier subclass: #MultiHeadUnifier
	instanceVariableNames: 'values'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Destructuring'!
!MultiHeadUnifier commentStamp: 'fbs 1/11/2012 18:51' prior: 0!
Just like a HeadUnifier, but I unify against the first N elements of some collection.!


!MultiHeadUnifier methodsFor: 'private' stamp: 'fbs 1/14/2012 21:18'!
unificationClosureWithSequence: aSequence in: termRelation
	aSequence ifEmpty: [^ self failToUnifyWith: aSequence].
	^ values unificationClosureWith: (aSequence first: values size) in: termRelation.! !

!MultiHeadUnifier methodsFor: 'private' stamp: 'fbs 1/11/2012 18:43'!
values: someObjects
	values := someObjects.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

MultiHeadUnifier class
	instanceVariableNames: 'values'!
rivate' stamp: 'fbs 1/11/2012 18:43'!
values: someObjects
	values := someObjects.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

MultiHeadUnifier class
	instanceVariableNames: 'values'!
