Dictionary subclass: #MostGeneralUnifier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!MostGeneralUnifier commentStamp: 'fbs 1/4/2012 10:31' prior: 0!
Given two structures s and t, each containing zero or more MetaVariables, to what values must those variables be set for s and t to be structurally equivalent?

If s := 1 and t := #x asVariable, then the most general unifier (mgu) will be {#x asVariable -> 1}.

If s := 2 and t := 1 then the mgu does not exist.

If s := t := 1 then the mgu is {}, or "there's no unification needed".!

