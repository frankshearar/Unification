
!Object methodsFor: '*Unification' stamp: 'fbs 10/7/2011 07:43'!
=? anObject
	^ self unifyWith: anObject.! !

!Object methodsFor: '*Unification' stamp: 'fbs 1/11/2012 20:33'!
failToUnifyWith: anObject
	UnificationFailure signalThis: self that: anObject.! !

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

!Object methodsFor: '*Unification' stamp: 'fbs 1/9/2012 18:54'!
unificationClosureWith: anObject in: termRelation
	anObject isMetaVariable
		ifTrue: [^ termRelation union: self with: anObject].

	^ anObject unificationClosureWithObject: self in: termRelation.! !

!Object methodsFor: '*Unification' stamp: 'fbs 1/9/2012 09:28'!
unificationClosureWithAlgebraic: anObject in: termRelation
	^ self unificationClosureWithSequence: anObject unapply in: termRelation.! !

!Object methodsFor: '*Unification' stamp: 'fbs 1/11/2012 19:17'!
unificationClosureWithObject: anObject in: termRelation
	^ (self = anObject)
		ifTrue: [termRelation union: self with: anObject]
		ifFalse: ["s ~= t" self failToUnifyWith: anObject]! !

!Object methodsFor: '*Unification' stamp: 'fbs 1/11/2012 19:18'!
unificationClosureWithSequence: aSequence in: termRelation
	^ self failToUnifyWith: aSequence.! !

!Object methodsFor: '*Unification' stamp: 'fbs 5/26/2011 20:42'!
unifyWith: anObject
	^ Unifier unify: self with: anObject.! !
