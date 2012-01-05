
!SequenceableCollection methodsFor: '*Unification' stamp: 'fbs 10/6/2011 22:10'!
findSolutionWithUnifier: aDictionary in: termRelation
	| newUnifier |
	newUnifier := aDictionary copy.
	self do:
		[:each | | d |
		d := (termRelation classFor: each)
			findSolutionWithUnifier: newUnifier in: termRelation.
		newUnifier addAll: d].
	^ newUnifier.! !

!SequenceableCollection methodsFor: '*Unification' stamp: 'fbs 10/6/2011 22:04'!
unificationClosureWith: anObject in: termRelation
	anObject unificationClosureWithSequence: self in: termRelation.! !

!SequenceableCollection methodsFor: '*Unification' stamp: 'fbs 10/6/2011 22:05'!
unificationClosureWithSequence: aCollection in: termRelation
	(self size = aCollection size) ifFalse: [UnificationFailure signal].
	self with: aCollection do:
		[:si :ti | (termRelation classFor: si) unificationClosureWith: (termRelation classFor: ti) in: termRelation].! !
ClosureWith: (rel find: ti) in: rel].
	^ rel.! !
