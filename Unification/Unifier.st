Object subclass: #Unifier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!Unifier commentStamp: 'fbs 7/23/2011 11:32' prior: 0!
I attempt to unify two structures, that is, find mappings between the MetaVariables (if any) within the two structures such that the structures represent the same structure.

I return a Dictionary containing the most general unifier (which might be empty if the two structures are identical), or I raise a UnificationFailure.!


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
_Unification Theory_ shows finding the solution starting only from s. However, ListUnifier unifies on an artificial node - a node that we construct and does not itself appear in either s or t. Thus we merge the partial solutions found by starting from a representative of each of the equivalence classes in the partition."
	^ partition inject: MostGeneralUnifier new into:
		[:mgu :node | mgu copy addAll: (SolutionFinder findSolutionFor: partition starting: node); yourself]! !
methodsFor: 'instance creation' stamp: 'fbs 5/25/2011 07:12'!
unify: left with: right
	^ self new unify: left with: right.! !
