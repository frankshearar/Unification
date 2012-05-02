Object subclass: #Unifier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!Unifier commentStamp: 'fbs 5/2/2012 09:50' prior: 0!
I attempt to unify two structures, that is, find mappings between the MetaVariables (if any) within the two structures such that the structures represent the same structure.

I return a MostGeneralUnifier (which might be empty if the two structures are identical), or I raise a UnificationFailure.!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Unifier class
	instanceVariableNames: ''!

!Unifier class methodsFor: 'instance creation' stamp: 'fbs 1/11/2012 22:38'!
unify: left with: right
	| partition |
	partition := VariableTrackingUnionFind
		usingArrayType: PersistentCollection
		partitioning: Dictionary new.
	partition := (partition find: left)
		unificationClosureWith: (partition find: right) in: partition.
	^ SolutionFinder findSolutionFor: partition.! !

!Unifier class methodsFor: 'instance creation' stamp: 'fbs 2/9/2012 19:14'!
unify: left with: middle with: right
	| partition |
	partition := VariableTrackingUnionFind
		usingArrayType: PersistentCollection
		partitioning: Dictionary new.
	partition := (partition find: left)
		unificationClosureWith: (partition find: middle) in: partition.
	partition := (partition find: middle)
		unificationClosureWith: (partition find: right) in: partition.
		
	^ SolutionFinder findSolutionFor: partition.! !
self]! !
methodsFor: 'instance creation' stamp: 'fbs 5/25/2011 07:12'!
unify: left with: right
	^ self new unify: left with: right.! !
