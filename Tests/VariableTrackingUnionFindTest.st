TestCase subclass: #VariableTrackingUnionFindTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification-Tests'!

!VariableTrackingUnionFindTest methodsFor: 'fixtures' stamp: 'fbs 1/4/2012 20:26'!
makePartition
	^ VariableTrackingUnionFind
		usingArrayType: PersistentCollection
		partitioning: Dictionary new! !


!VariableTrackingUnionFindTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 16:25'!
testAddingNonVariableToVariableClassMakesNonVariableTheRepresentative
	| v |
	v := self makePartition.
	v := v union: #x asVariable with: 1.
	self assert: 1 equals: (v find: 1).
	self assert: 1 equals: (v find: #x asVariable).! !

!VariableTrackingUnionFindTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 16:25'!
testAddingVariableToClassMakesNonVariableTheRepresentative
	| v |
	v := self makePartition.
	v := v union: 1 with: #x asVariable.
	self assert: 1 equals: (v find: 1).
	self assert: 1 equals: (v find: #x asVariable).! !

!VariableTrackingUnionFindTest methodsFor: 'testing' stamp: 'fbs 1/4/2012 16:26'!
testAddingVariableToVariableClassMakesOriginalVariableTheRepresentative
	| v |
	v := self makePartition.
	v := v union: #x asVariable with: #y asVariable.
	self assert: #y asVariable equals: (v find: #y asVariable).
	self assert: #y asVariable equals: (v find: #x asVariable).! !
equals: (v find: #x asVariable).! !
