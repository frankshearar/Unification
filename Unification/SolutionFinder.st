Object subclass: #SolutionFinder
	instanceVariableNames: 'acyclic visited partition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!SolutionFinder commentStamp: 'fbs 1/4/2012 10:29' prior: 0!
Given an equivalence relation (partition) on some set of nodes, each class potentially containing one or more MetaVariables, construct a MostGeneralUnifier.!


!SolutionFinder methodsFor: 'private' stamp: 'fbs 1/4/2012 14:23'!
findSolution: anObject using: anMGU
	| newUnifier schemaTerm |
	schemaTerm := partition find: anObject.
	(acyclic includes: schemaTerm) ifTrue: [^ anMGU "s is not part of a cycle."].
	(visited includes: schemaTerm) ifTrue: [UnificationFailure signal. "Cycle detected."].
	
	newUnifier := anMGU copy.
	visited add: schemaTerm.
	newUnifier addAll: (schemaTerm findSolutionWithUnifier: newUnifier in: self).
	visited remove: schemaTerm.
	
	acyclic add: schemaTerm.
	(partition varsAt: schemaTerm) do:
		[:x | (x ~= schemaTerm) ifTrue: [newUnifier at: x put: schemaTerm]].
	^ newUnifier.! !


!SolutionFinder methodsFor: 'unification' stamp: 'fbs 1/4/2012 11:45'!
findSolutionFor: aVariableAvoidingUnionFind starting: anObject
	partition := aVariableAvoidingUnionFind.
	acyclic := OrderedCollection new.
	visited := OrderedCollection new.
	^ self findSolution: anObject using: MostGeneralUnifier new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

SolutionFinder class
	instanceVariableNames: ''!

!SolutionFinder class methodsFor: 'instance creation' stamp: 'fbs 1/4/2012 11:35'!
findSolutionFor: aVariableAvoidingUnionFind starting: anObject
	^ self new findSolutionFor: aVariableAvoidingUnionFind starting: anObject.! !
