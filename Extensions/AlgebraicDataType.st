
!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 1/4/2012 11:31'!
findSolutionWithUnifier: anMGU in: solutionFinder
	| newUnifier |
	newUnifier := anMGU copy.
	self children do:
		[:each | | d |
		d := solutionFinder findSolution: each using: anMGU.
		newUnifier addAll: d].
	^ newUnifier.! !

!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 5/25/2011 22:31'!
isMetaVariable
	^ self unapply first = #Variable.! !

!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 8/9/2011 07:32'!
or: anObject
	^ OrUnifier left: self right: anObject! !

!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 1/4/2012 20:20'!
unificationClosureWith: anObject in: termRelation
	anObject isMetaVariable
		ifTrue: [^ termRelation union: self with: anObject].

	^ anObject unificationClosureWithAlgebraic: self in: termRelation.! !

!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 1/11/2012 20:16'!
unificationClosureWithAlgebraic: anObject in: termRelation
	"s = f(s1, ..., sm), t = g(t1, ..., tn) where m, n > 0"
	| partition |
	(self type = anObject type) ifFalse: [^ self failToUnifyWith: anObject. "f ~= g"].
	(self arity = anObject arity) ifFalse: [^ self failToUnifyWith: anObject. "m ~= n"].
	partition := termRelation.
	self children with: anObject children do:
		[:si :ti | partition := (partition find: si) unificationClosureWith: (partition find: ti) in: partition].
	^ partition.! !
