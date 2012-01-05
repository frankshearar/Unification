Object subclass: #TermRelation
	instanceVariableNames: 'map'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!TermRelation commentStamp: 'fbs 5/28/2011 15:43' prior: 0!
I represent the term relation we build up as part of unifying two structures.!


!TermRelation methodsFor: 'accessing' stamp: 'fbs 5/28/2011 18:50'!
classFor: anObject
	^ map
		at: anObject
		ifAbsentPut: [UnificationEquivalenceClass decorate: anObject].! !


!TermRelation methodsFor: 'initialize-release' stamp: 'fbs 5/28/2011 15:52'!
initialize
	super initialize.
	map := Dictionary new.! !


!TermRelation methodsFor: 'as yet unclassified' stamp: 'fbs 7/26/2011 21:44'!
union: thisObject with: thatObject
	(self classFor: thisObject) findRepresentative schemaTerm
			union: (self classFor: thatObject) findRepresentative schemaTerm! !
