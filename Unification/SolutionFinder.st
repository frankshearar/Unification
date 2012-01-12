Object subclass: #SolutionFinder
	instanceVariableNames: 'acyclic visited partition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!SolutionFinder commentStamp: 'fbs 1/4/2012 10:29' prior: 0!
Given an equivalence relation (partition) on some set of nodes, each class potentially containing one or more MetaVariables, construct a MostGeneralUnifier.!


!SolutionFinder methodsFor: 'private' stamp: 'fbs 1/11/2012 20:08'!
findSolution: anObject using: anMGU
	| newUnifier schemaTerm |
	schemaTerm := partition find: anObject.
	(acyclic includes: schemaTerm) ifTrue: [^ anMGU "s is not part of a cycle."].
	(visited includes: schemaTerm) ifTrue: [^ UnificationCycleFailure signalCycleOn: schemaTerm. "Cycle detected."].
	
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

!SolutionFinder class methodsFor: 'instance creation' stamp: 'fbs 1/12/2012 09:18'!
findSolutionFor: aVariableAvoidingUnionFind
	"The original algorithm from Baader & Synder's _Unification Theory_ shows finding the solution starting only from the root of one of the two operands s and t to be unified. However, ListUnifier unifies on an artificial node - a node that we construct and does not itself appear in either s or t. Thus we merge the partial solutions found by starting from a representative of each of the equivalence classes in the partition."
	^ aVariableAvoidingUnionFind inject: MostGeneralUnifier new into:
		[:mgu :node | mgu copy addAll: (self new findSolutionFor: aVariableAvoidingUnionFind starting: node); yourself]! !
