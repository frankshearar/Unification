DestructuringUnifier subclass: #HeadUnifier
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Destructuring'!
!HeadUnifier commentStamp: 'fbs 10/13/2011 07:29' prior: 0!
I represent the head of an OrderedCollection.!


!HeadUnifier methodsFor: 'structuring' stamp: 'fbs 1/10/2012 09:27'!
| aTail
	^ ListUnifier head: self tail: aTail.! !


!HeadUnifier methodsFor: 'unification' stamp: 'fbs 1/9/2012 19:01'!
findSolutionWithUnifier: anMGU in: solutionFinder
	| d newUnifier |
	newUnifier := anMGU copy.
	d := solutionFinder findSolution: value using: anMGU.
	newUnifier addAll: d.
	^ newUnifier.! !

!HeadUnifier methodsFor: 'unification' stamp: 'fbs 1/11/2012 21:39'!
unificationClosureWith: anObject in: termRelation
	anObject isMetaVariable
		ifTrue: [^ termRelation union: self with: anObject].
	anObject isCollection
		ifFalse: [^ self failToUnifyWith: anObject].
	anObject isEmpty
		ifTrue: [^ self failToUnifyWith: anObject].
	^ self matchAgainst: anObject in: termRelation.! !

!HeadUnifier methodsFor: 'unification' stamp: 'fbs 1/11/2012 20:16'!
unificationClosureWithSequence: aSequence in: termRelation
	aSequence ifEmpty: [^ self failToUnifyWith: aSequence].
	^ self matchAgainst: aSequence in: termRelation.! !


!HeadUnifier methodsFor: 'private' stamp: 'fbs 1/11/2012 18:42'!
matchAgainst: aCollection in: termRelation
	^ value unificationClosureWith: aCollection first in: termRelation.! !

!HeadUnifier methodsFor: 'private' stamp: 'fbs 10/13/2011 07:31'!
value: anObject
	value := anObject.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

HeadUnifier class
	instanceVariableNames: ''!

!HeadUnifier class methodsFor: 'instance creation' stamp: 'fbs 10/13/2011 07:30'!
named: aSymbol
	^ self value: aSymbol asVariable.! !

!HeadUnifier class methodsFor: 'instance creation' stamp: 'fbs 10/13/2011 07:31'!
value: anObject
	^ self new value: anObject.! !

!HeadUnifier class methodsFor: 'instance creation' stamp: 'fbs 1/11/2012 14:01'!
values: someObjects
	^ MultiHeadUnifier new values: someObjects.! !
