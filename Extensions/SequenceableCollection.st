
!SequenceableCollection methodsFor: '*Unification' stamp: 'fbs 1/4/2012 11:33'!
findSolutionWithUnifier: anMGU in: solutionFinder
	| newUnifier |
	newUnifier := anMGU copy.
	self do:
		[:each | | d |
		d := solutionFinder	findSolution: each using: newUnifier.
		newUnifier addAll: d].
	^ newUnifier.! !

!SequenceableCollection methodsFor: '*Unification' stamp: 'fbs 1/3/2012 15:30'!
unificationClosureWith: anObject in: termRelation
	anObject isMetaVariable
		ifTrue: [^ termRelation union: self with: anObject].
		
	^ anObject unificationClosureWithSequence: self in: termRelation.! !

!SequenceableCollection methodsFor: '*Unification' stamp: 'fbs 1/11/2012 19:18'!
unificationClosureWithSequence: aCollection in: termRelation
	| rel |
	(self size = aCollection size) ifFalse: [^ self failToUnifyWith: aCollection].
	rel := termRelation.
	self with: aCollection do:
		[:si :ti | rel := (rel find: si) unificationClosureWith: (rel find: ti) in: rel].
	^ rel.! !
