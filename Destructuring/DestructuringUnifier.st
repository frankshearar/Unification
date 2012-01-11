Object subclass: #DestructuringUnifier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Destructuring'!
!DestructuringUnifier commentStamp: 'fbs 1/10/2012 09:25' prior: 0!
A DestructuringUnifier is an object used to "destructure" an object, that is, to tear some object apart in some way. For instance, the classic Prolog statement [H | T] = [1, 2, 3] might be translated as (ConcatenatedList headNamed: #h tailNamed: #t) =? #(1 2 3).!

