Object subclass: #UnificationMatcher
	instanceVariableNames: 'cases otherwise'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!UnificationMatcher commentStamp: 'fbs 7/28/2011 22:15' prior: 0!
I provide a unification-based case-like statement.

I use memoisation as an optimisation.!


!UnificationMatcher methodsFor: 'applying' stamp: 'fbs 6/14/2012 09:17'!
match: anObject
	"Iterate through the cases. As we evaluate the key thunks, replace them with the evaluated values. Much uglier than the naive implementation, but MUCH faster."
	| newCases result unmatch |
	result := unmatch := Object new.
	
	"As we try unify against the key thunk, build up a new Dictionary with the unifying key thunk memoised."
	newCases := OrderedCollection new.
	cases associationsDo:
		[:assoc | | mgu newKey |
			[newKey := assoc key isBlock ifTrue: [assoc key value] ifFalse: [assoc key].
			mgu := newKey unifyWith: anObject.
			result = unmatch ifTrue: [result := assoc value cull: mgu].
			newCases
				add: newKey;
				add: assoc value.] on: UnificationFailure do: ["nothing"]].

	cases := Dictionary newFromPairs: newCases.
	
	^ result == unmatch
		ifTrue: [otherwise value]
		ifFalse: [result].! !


!UnificationMatcher methodsFor: 'initialize-release' stamp: 'fbs 1/8/2012 22:05'!
matcherUsing: aBlockAssociationCollection
	self matcherUsing: aBlockAssociationCollection otherwise: [self caseError].! !

!UnificationMatcher methodsFor: 'initialize-release' stamp: 'fbs 8/8/2011 22:22'!
matcherUsing: aBlockAssociationCollection otherwise: aBlock
	cases := aBlockAssociationCollection asOrderedCollection.
	otherwise := aBlock.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

UnificationMatcher class
	instanceVariableNames: ''!

!UnificationMatcher class methodsFor: 'instance creation' stamp: 'fbs 7/28/2011 22:29'!
matcherUsing: aBlockAssociationCollection
	^ self new matcherUsing: aBlockAssociationCollection.! !

!UnificationMatcher class methodsFor: 'instance creation' stamp: 'fbs 7/28/2011 22:14'!
matcherUsing: aBlockAssociationCollection otherwise: aBlock
	^ self new matcherUsing: aBlockAssociationCollection otherwise: aBlock.! !
ion new.
	dictionary associationsDo: [:k :v |
		newAssocs
			add: (k = key ifTrue: [newKey] ifFalse: [k]);
			add: v.].
	^ Dictionary newFromPairs: newAssocs.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

UnificationMatcher class
	instanceVariableNames: ''!

!UnificationMatcher class methodsFor: 'instance creation' stamp: 'fbs 7/28/2011 22:29'!
matcherUsing: aBlockAssociationCollection
	^ self new matcherUsing: aBlockAssociationCollection.! !

!UnificationMatcher class methodsFor: 'instance creation' stamp: 'fbs 7/28/2011 22:14'!
matcherUsing: aBlockAssociationCollection otherwise: aBlock
	^ self new matcherUsing: aBlockAssociationCollection otherwise: aBlock.! !
