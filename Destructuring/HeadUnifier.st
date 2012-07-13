DestructuringUnifier subclass: #HeadUnifier
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Destructuring'!
!HeadUnifier commentStamp: 'fbs 10/13/2011 07:29' prior: 0!
I represent the head of an OrderedCollection.!


!HeadUnifier methodsFor: 'evaluating' stamp: 'fbs 1/14/2012 21:13'!
value
	^ value.! !


!HeadUnifier methodsFor: 'structuring' stamp: 'fbs 1/16/2012 13:13'!
| aTail
	^ ListUnifier head: self value tail: aTail.! !


!HeadUnifier methodsFor: 'unification' stamp: 'fbs 1/12/2012 09:34'!
findSolutionWithUnifier: anMGU in: solutionFinder
	^ solutionFinder findSolution: value using: anMGU.! !

!HeadUnifier methodsFor: 'unification' stamp: 'fbs 1/14/2012 21:06'!
unificationClosureWith: anObject in: termRelation
	anObject isMetaVariable
		ifTrue: [^ termRelation union: self with: anObject].
	anObject isCollection
		ifFalse: [^ self failToUnifyWith: anObject].
	^ self unificationClosureWithSequence: anObject in: termRelation! !

!HeadUnifier methodsFor: 'unification' stamp: 'fbs 1/14/2012 21:18'!
unificationClosureWithSequence: aSequence in: termRelation
	aSequence ifEmpty: [^ self failToUnifyWith: aSequence].
	^ value unificationClosureWith: aSequence first in: termRelation.! !


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
