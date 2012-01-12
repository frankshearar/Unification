TestCase subclass: #MostGeneralUnifierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!MostGeneralUnifierTest methodsFor: 'testing - accessing' stamp: 'fbs 1/12/2012 18:52'!
testAtReturnsValueForSomeKey
	self assert: 2 equals: ((MostGeneralUnifier new at: 1 put: 2) at: 1).! !

!MostGeneralUnifierTest methodsFor: 'testing - accessing' stamp: 'fbs 1/12/2012 18:53'!
testAtThrowsExceptionForMissingKey
	self should: [MostGeneralUnifier new at: 1] raise: KeyNotFound.! !

!MostGeneralUnifierTest methodsFor: 'testing - accessing' stamp: 'fbs 1/12/2012 18:55'!
testSizeReturnsNumberOfKeys
	#(1 2 3 4)
		inject: MostGeneralUnifier new
		into: [:mgu :i | | m |
			m := mgu at: i put: i.
			self assert: i equals: m size.
			m].! !


!MostGeneralUnifierTest methodsFor: 'testing - adding' stamp: 'fbs 1/12/2012 09:37'!
testAddAllAddsOldKeys
	| old new |
	old := MostGeneralUnifier new.
	new := old addAll: (MostGeneralUnifier newFromPairs: #(1 2)).
	self assert: (new includesKey: 1).! !

!MostGeneralUnifierTest methodsFor: 'testing - adding' stamp: 'fbs 1/12/2012 09:37'!
testAddAllLeavesOriginalInstanceUntouched
	| old new |
	old := MostGeneralUnifier new.
	new := old addAll: (MostGeneralUnifier newFromPairs: #(1 2)).
	self deny: (old includesKey: 1).! !

!MostGeneralUnifierTest methodsFor: 'testing - adding' stamp: 'fbs 1/12/2012 09:45'!
testAddAllReturnsNewMGU
	| old new |
	old := MostGeneralUnifier new.
	new := old addAll: (MostGeneralUnifier newFromPairs: #(1 2)).
	self deny: old = new.! !

!MostGeneralUnifierTest methodsFor: 'testing - adding' stamp: 'fbs 1/12/2012 09:46'!
testAtPutAddsKeyValue
	| old new |
	old := MostGeneralUnifier new.
	new := old at: 1 put: 2.
	self assert: (new includesKey: 1).
	self assert: 2 equals: (new at: 1).! !

!MostGeneralUnifierTest methodsFor: 'testing - adding' stamp: 'fbs 1/12/2012 09:46'!
testAtPutLeavesOriginalInstanceUntouched
	| old new |
	old := MostGeneralUnifier new.
	new := old at: 1 put: 2.
	self deny: (old includesKey: 1).! !

!MostGeneralUnifierTest methodsFor: 'testing - adding' stamp: 'fbs 1/12/2012 09:45'!
testAtPutReturnsNewMGU
	| old new |
	old := MostGeneralUnifier new.
	new := old at: 1 put: 2.
	self deny: old = new.! !


!MostGeneralUnifierTest methodsFor: 'testing - testing' stamp: 'fbs 1/12/2012 18:51'!
testIncludesKeyReturnsFalseWhenNoKeyPresent
	self deny: (MostGeneralUnifier new includesKey: 1).! !

!MostGeneralUnifierTest methodsFor: 'testing - testing' stamp: 'fbs 1/12/2012 18:52'!
testIncludesKeyReturnsTrueWhenKeyPresent
	self assert: ((MostGeneralUnifier new at: 1 put: 2) includesKey: 1).! !

!MostGeneralUnifierTest methodsFor: 'testing - testing' stamp: 'fbs 1/12/2012 19:11'!
testIsEmptyReturnsFalseWhenNotEmpty
	self deny: (MostGeneralUnifier new at: 1 put: 2) isEmpty.! !

!MostGeneralUnifierTest methodsFor: 'testing - testing' stamp: 'fbs 1/12/2012 19:11'!
testIsEmptyReturnsTrueWhenEmpty
	self assert: MostGeneralUnifier new isEmpty.! !


!MostGeneralUnifierTest methodsFor: 'testing - printing' stamp: 'fbs 1/12/2012 20:27'!
testPrintOnEmptyMGUPrintsNicely
	| mgu |
	mgu := MostGeneralUnifier new.
	self assert: 'MostGeneralUnifier()' equals: mgu printString.! !

!MostGeneralUnifierTest methodsFor: 'testing - printing' stamp: 'fbs 1/12/2012 20:27'!
testPrintOnPrintsAlmostLikeDictionary
	| mgu |
	mgu := MostGeneralUnifier newFrom: {1 -> 2}.
	self assert: 'MostGeneralUnifier(1->2 )' equals: mgu printString.! !
