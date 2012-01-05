
!Object methodsFor: '*Unification' stamp: 'fbs 5/25/2011 22:33'!
isMetaVariable
	^ false.! !

!Object methodsFor: '*Unification' stamp: 'fbs 7/23/2011 11:25'!
matchOneOf: aBlockAssociationCollection
	"The elements of aBlockAssociationCollection are associations between blocks.
	 Answer the evaluated value of the first association in aBlockAssociationCollection
	 whose evaluated key unifies with the receiver.  If no match is found, report an error."

	^ self matchOneOf: aBlockAssociationCollection otherwise: [self caseError].! !

!Object methodsFor: '*Unification' stamp: 'fbs 7/28/2011 14:38'!
matchOneOf: aBlockAssociationCollection otherwise: aBlock
	"The elements of aBlockAssociationCollection are associations between blocks.
	 Answer the evaluated value of the first association in aBlockAssociationCollection
	 whose evaluated key unifies with the receiver.  If no match is found, answer the result
	 of evaluating aBlock."
	aBlockAssociationCollection associationsDo:
		[:assoc | | mgu |
			[mgu := assoc key value =? self.
			^ assoc value cull: mgu] on: UnificationFailure do: ["nothing"]].
	^ aBlock value! !

!Object methodsFor: '*Unification' stamp: 'fbs 7/26/2011 21:44'!
unificationClosureWith: anObject in: termRelation
	(self = anObject)
		ifTrue: [termRelation union: self with: anObject]
		ifFalse: ["s ~= t" UnificationFailure signal]! !

!Object methodsFor: '*Unification' stamp: 'fbs 6/2/2011 13:50'!
unificationClosureWithAlgebraic: anObject in: termRelation
	UnificationFailure signal.! !

!Object methodsFor: '*Unification' stamp: 'fbs 5/26/2011 20:42'!
unifyWith: anObject
	^ Unifier unify: self with: anObject.! !
fy: self with: anObject.! !
 stamp: 'fbs 5/26/2011 20:42'!
unifyWith: anObject
	^ Unifier unify: self with: anObject.! !
nFailure signal.! !

!Object methodsFor: '*Unification' stamp: 'fbs 1/2/2012 20:22'!
unificationClosureWithVariable: aMetaVariable in: termRelation
	^ termRelation union: aMetaVariable with: self.! !
