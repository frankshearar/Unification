DestructuringUnifier subclass: #ListUnifier
	instanceVariableNames: 'head tail'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Destructuring'!
!ListUnifier commentStamp: 'fbs 1/11/2012 18:53' prior: 0!
I destructure a (sequenceable) collection into a head and a tail. For instance,

    ListUnifier headNamed: #h tailNamed: #t =? #(1 2 3)

unifies h with 1 and t with #(2 3).!



!ListUnifier methodsFor: 'private' stamp: 'fbs 10/13/2011 07:35'!
head: anObject tail: anotherObject
	head := anObject.
	tail := anotherObject.! !


!ListUnifier methodsFor: 'unification' stamp: 'fbs 1/10/2012 19:04'!
findSolutionWithUnifier: anMGU in: solutionFinder
	| newUnifier |
	newUnifier := anMGU copy.
	{head. tail.} do:
		[:d |
		d := solutionFinder findSolution: head using: anMGU.
		newUnifier addAll: d].
	^ newUnifier.! !

!ListUnifier methodsFor: 'unification' stamp: 'fbs 1/11/2012 10:37'!
unificationClosureWith: anObject in: termRelation
	| partition |
	anObject isMetaVariable
		ifTrue: [^ termRelation union: self with: anObject].
	anObject isCollection
		ifFalse: [^ UnificationFailure signal].
	anObject isEmpty
		ifTrue: [^ UnificationFailure signal].
		
	"It would be nice to drive the type checking into head and tail. The trouble is that tail needs to know head's size. Rather than polluting tail's API, we hold our nose and suffer the below."
	"Calculating headSize = 1 if not a collection doesn't help because if size = 1, there's still a difference between x and {x}."
	partition := head isCollection
		ifTrue: [head unificationClosureWith: (anObject first: head size) in: termRelation]
		ifFalse: [head unificationClosureWith: anObject first in: termRelation].
	^ head isCollection
		ifTrue: [tail unificationClosureWith: (anObject allButFirst: head size) in: partition]
		ifFalse: [tail unificationClosureWith: anObject allButFirst in: partition].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

ListUnifier class
	instanceVariableNames: ''!

!ListUnifier class methodsFor: 'instance creation' stamp: 'fbs 10/13/2011 07:35'!
head: anObject tail: anotherObject
	^ self new head: anObject tail: anotherObject.! !

!ListUnifier class methodsFor: 'instance creation' stamp: 'fbs 1/11/2012 19:02'!
head: anObject tailNamed: tailSymbol
	^ self new head: anObject tail: tailSymbol asVariable.! !

!ListUnifier class methodsFor: 'instance creation' stamp: 'fbs 1/11/2012 19:01'!
headNamed: headSymbol tail: anObject
	^ self new head: headSymbol asVariable tail: anObject.! !

!ListUnifier class methodsFor: 'instance creation' stamp: 'fbs 10/13/2011 07:36'!
headNamed: headSymbol tailNamed: tailSymbol
	^ self new head: headSymbol asVariable tail: tailSymbol asVariable.! !
