Object subclass: #Unifier
	instanceVariableNames: 'termRelation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!Unifier commentStamp: 'fbs 7/23/2011 11:32' prior: 0!
I attempt to unify two structures, that is, find mappings between the MetaVariables (if any) within the two structures such that the structures represent the same structure.

I return a Dictionary containing the most general unifier (which might be empty if the two structures are identical), or I raise a UnificationFailure.!


!Unifier methodsFor: 'evaluating' stamp: 'fbs 1/4/2012 20:26'!
unify: s with: t
	termRelation := VariableTrackingUnionFind usingArrayType: PersistentCollection partitioning: Dictionary new.
	termRelation := (termRelation find: s) unificationClosureWith: (termRelation find: t) in: termRelation.
	^ SolutionFinder findSolutionFor: termRelation starting: s.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Unifier class
	instanceVariableNames: ''!

!Unifier class methodsFor: 'instance creation' stamp: 'fbs 5/25/2011 07:12'!
unify: left with: right
	^ self new unify: left with: right.! !
