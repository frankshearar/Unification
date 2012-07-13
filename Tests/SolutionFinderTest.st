TestCase subclass: #SolutionFinderTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!
!SolutionFinderTest commentStamp: 'fbs 1/4/2012 10:39' prior: 0!
Most of SolutionFinder's tests are found in UnificationTest.!


!SolutionFinderTest methodsFor: 'fixtures' stamp: 'fbs 1/5/2012 09:28'!
makePartition
	| partition |
	partition := VariableTrackingUnionFind usingArrayType: PersistentCollection partitioning: Dictionary new.
	partition := (partition find: 1) unificationClosureWith: (partition find: #x asVariable) in: partition.
	^ partition.! !


!SolutionFinderTest methodsFor: 'testing - instance creation' stamp: 'fbs 1/11/2012 22:43'!
testCanCreateFinder
	| partition |
	partition := self makePartition.
	SolutionFinder findSolutionFor: partition.! !
