Error subclass: #MostGeneralUnifierMergeFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!MostGeneralUnifierMergeFailure commentStamp: 'fbs 5/2/2012 10:05' prior: 0!
I represent the failure to merge two MostGeneralUnifiers with conflicting bindings - one says x -> 1 and the other says x -> 2, for instance.!
