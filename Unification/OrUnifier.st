Object subclass: #OrUnifier
	instanceVariableNames: 'left right'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!OrUnifier commentStamp: 'fbs 8/8/2011 22:31' prior: 0!
An OrUnifier is an object that allows an object to match one of two different objects:

OrUnifier
	left: (Node left: #x asVariable)
	right: (Node right: #x asVariable)
	
returns something that unifies with single-child Nodes.!


!OrUnifier methodsFor: 'private' stamp: 'fbs 8/8/2011 22:33'!
left: leftObject right: rightObject
	left := leftObject.
	right := rightObject.! !


!OrUnifier methodsFor: '*Unification' stamp: 'fbs 8/9/2011 07:36'!
unifyWith: anObject
	[^ left unifyWith: anObject]
		on: UnificationFailure do: [^ right unifyWith: anObject].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

OrUnifier class
	instanceVariableNames: ''!

!OrUnifier class methodsFor: 'instance creation' stamp: 'fbs 8/8/2011 22:33'!
left: leftObject right: rightObject
	^ self new left: leftObject right: rightObject.! !
ght unifyWith: anObject].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

OrUnifier class
	instanceVariableNames: ''!

!OrUnifier class methodsFor: 'instance creation' stamp: 'fbs 8/8/2011 22:33'!
left: leftObject right: rightObject
	^ self new left: leftObject right: rightObject.! !
