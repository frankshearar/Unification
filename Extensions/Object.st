
!Object methodsFor: '*Unification' stamp: 'fbs 10/7/2011 07:43'!
=? anObject
	^ self unifyWith: anObject.! !

!Object methodsFor: '*Unification' stamp: 'fbs 1/4/2012 11:32'!
findSolutionWithUnifier: anMGU in: solutionFinder
	^ anMGU.! !

!Object methodsFor: '*Unification' stamp: 'fbs 5/25/2011 22:33'!
isMetaVariable
	^ false.! !

!Object methodsFor: '*Unification' stamp: 'fbs 7/23/2011 11:25'!
matchOneOf: aBlockAssociationCollection
	"The elements of aBlockAssociationCollection are associations between blocks.
	 Answer the evaluated value of the first association in aBlockAssociationCollection
	 whose evaluated key unifies with the receiver.  If no match is found, report an error."

	^ self matchOneOf: aBlockAssociationCollection otherwise: [self caseError].! !

!Object methodsFor: '*Unification' stamp: 'fbs 8/8/2011 19:07'!
matchOneOf: someAssociations otherwise: aBlock
	"The elements of aBlockAssociationCollection are associations between blocks.
	 Answer the evaluated value of the first association in aBlockAssociationCollection
	 whose evaluated key unifies with the receiver.  If no match is found, answer the result
	 of evaluating aBlock."
	^ (UnificationMatcher matcherUsing: someAssociations otherwise: aBlock) match: self.! !

!Object methodsFor: '*Unification' stamp: 'fbs 1/3/2012 15:28'!
unificationClosureWith: anObject in: termRelation
	anObject isMetaVariable
		ifTrue: [^ termRelation union: self with: anObject].

	^ (self = anObject)
		ifTrue: [termRelation union: self with: anObject]
		ifFalse: ["s ~= t" UnificationFailure signal]! !

!Object methodsFor: '*Unification' stamp: 'fbs 6/2/2011 13:50'!
unificationClosureWithAlgebraic: anObject in: termRelation
	UnificationFailure signal.! !

!Object methodsFor: '*Unification' stamp: 'fbs 1/4/2012 21:34'!
unificationClosureWithSequence: aSequence in: termRelation
	UnificationFailure signal.! !

!Object methodsFor: '*Unification' stamp: 'fbs 5/26/2011 20:42'!
unifyWith: anObject
	^ Unifier unify: self with: anObject.! !
	^ termRelation union: aMetaVariable with: self.! !

!Object methodsFor: '*Unification' stamp: 'fbs 5/26/2011 20:42'!
unifyWith: anObject
	^ Unifier unify: self with: anObject.! !
