DestructuringUnifier subclass: #ListUnifier
	instanceVariableNames: 'head tail'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Destructuring'!
!ListUnifier commentStamp: 'fbs 1/11/2012 18:53' prior: 0!
I destructure a (sequenceable) collection into a head and a tail. For instance,

    ListUnifier headNamed: #h tailNamed: #t =? #(1 2 3)

unifies h with 1 and t with #(2 3).!




!ListUnifier methodsFor: 'unification' stamp: 'fbs 1/12/2012 09:39'!
findSolutionWithUnifier: anMGU in: solutionFinder
	^ {head. tail.}
		inject: anMGU
		into: [:mgu :each | solutionFinder findSolution: each using: mgu].
! !

!ListUnifier methodsFor: 'unification' stamp: 'fbs 1/14/2012 15:27'!
unificationClosureWith: anObject in: termRelation
	anObject isMetaVariable
		ifTrue: [^ termRelation union: self with: anObject].
	anObject isCollection
		ifFalse: [^ self failToUnifyWith: anObject].
	anObject isEmpty
		ifTrue: [^ self failToUnifyWith: anObject].
		
	^ self unificationClosureWithSequence: anObject in: termRelation! !

!ListUnifier methodsFor: 'unification' stamp: 'fbs 1/14/2012 15:27'!
unificationClosureWithSequence: someObjects in: termRelation
	| h t partition |
	"It would be nice to drive the type checking into head and tail. The trouble is that tail needs to know head's size. Rather than polluting tail's API, we hold our nose and suffer the below."
	"Calculating headSize = 1 if not a collection doesn't help because if size = 1, there's still a difference between x and {x}."
	h := head isCollection
		ifTrue: [someObjects first: head size]
		ifFalse: [1].
	t := head isCollection
		ifTrue: [someObjects allButFirst: head size]
		ifFalse: [someObjects allButFirst].
	partition := head unificationClosureWith: h in: termRelation.
	^ tail unificationClosureWith: t in: partition.! !


!ListUnifier methodsFor: 'private' stamp: 'fbs 10/13/2011 07:35'!
head: anObject tail: anotherObject
	head := anObject.
	tail := anotherObject.! !

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
: headSymbol tailNamed: tailSymbol
	^ self new head: headSymbol asVariable tail: tailSymbol asVariable.! !
