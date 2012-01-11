DestructuringUnifier subclass: #TailUnifier
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Destructuring'!
!TailUnifier commentStamp: 'fbs 10/13/2011 07:33' prior: 0!
I represent the tail (or rest) of an OrderedCollection.!


!TailUnifier methodsFor: 'unification' stamp: 'fbs 1/9/2012 19:12'!
findSolutionWithUnifier: anMGU in: solutionFinder
	| d newUnifier |
	newUnifier := anMGU copy.
	d := solutionFinder findSolution: value using: anMGU.
	newUnifier addAll: d.
	^ newUnifier.! !

!TailUnifier methodsFor: 'unification' stamp: 'fbs 1/11/2012 19:20'!
unificationClosureWith: anObject in: termRelation
	anObject isMetaVariable
		ifTrue: [^ termRelation union: self with: anObject].
	anObject isCollection
		ifFalse: [^ self failToUnifyWith: anObject].
	anObject isEmpty
		ifTrue: [^ self failToUnifyWith: anObject].
	^ value unificationClosureWith: anObject allButFirst in: termRelation.! !

!TailUnifier methodsFor: 'unification' stamp: 'fbs 1/11/2012 19:20'!
unificationClosureWithSequence: aSequence in: termRelation
	aSequence ifEmpty: [^ self failToUnifyWith: aSequence].
	^ value unificationClosureWith: aSequence allButFirst in: termRelation.! !


!TailUnifier methodsFor: 'private' stamp: 'fbs 10/13/2011 07:33'!
value: anObject
	value := anObject.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

TailUnifier class
	instanceVariableNames: ''!

!TailUnifier class methodsFor: 'instance creation' stamp: 'fbs 10/13/2011 07:33'!
named: aSymbol
	^ self value: aSymbol asVariable.! !

!TailUnifier class methodsFor: 'instance creation' stamp: 'fbs 10/13/2011 07:33'!
value: anObject
	^ self new value: anObject.! !
