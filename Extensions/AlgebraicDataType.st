
!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 5/30/2011 20:20'!
findSolutionWithUnifier: aDictionary in: termRelation
	| newUnifier |
	newUnifier := aDictionary copy.
	self children do:
		[:each | | d |
		d := (termRelation classFor: each)
			findSolutionWithUnifier: newUnifier in: termRelation.
		newUnifier addAll: d].
	^ newUnifier.! !

!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 5/25/2011 22:31'!
isMetaVariable
	^ self unapply first = #Variable.! !

!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 6/2/2011 13:51'!
unificationClosureWith: anObject in: termRelation
	anObject unificationClosureWithAlgebraic: self in: termRelation.! !

!AlgebraicDataType methodsFor: '*Unification' stamp: 'fbs 6/2/2011 13:54'!
unificationClosureWithAlgebraic: anObject in: termRelation
	"s = f(s1, ..., sm), t = g(t1, ..., tn) where m, n > 0"
	(self type = anObject type) ifFalse: [UnificationFailure signal. "f ~= g"].
	(self arity = anObject arity) ifFalse: [UnificationFailure signal. "m ~= n"].
	self children with: anObject children do:
		[:si :ti | (termRelation classFor: si) unificationClosureWith: (termRelation classFor: ti) in: termRelation].! !
