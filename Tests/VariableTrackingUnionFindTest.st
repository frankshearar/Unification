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

!VariableTrackingUnionFindTest methodsFor: 'testing' stamp: 'fbs 1/15/2012 15:56'!
testUnifyingWithVariableLeavesOriginalInstanceUnchanged
	| p1 p2 |
	p1 := self makePartition.
	p2 := p1 union: 1 with: #x asVariable.
	self assert: #() equals: p1 variableContainingClasses asArray.! !


!VariableTrackingUnionFindTest methodsFor: 'testing - accessing' stamp: 'fbs 1/15/2012 15:46'!
testVariableContainingClassesReturnsCollectionOnNonVariablePartition
	| partition |
	partition := self makePartition union: #x asVariable with: 1.
	partition := partition union: #y asVariable with: 2.
	partition := partition union: 3 with: 4.
	self assert: #(1 2) sort equals: partition variableContainingClasses asArray sort.! !

!VariableTrackingUnionFindTest methodsFor: 'testing - accessing' stamp: 'fbs 1/15/2012 15:46'!
testVariableContainingClassesReturnsEmptyCollectionOnNonVariablePartition
	self assert: #() equals: (self makePartition union: 1 with: 2) variableContainingClasses asArray.! !


!VariableTrackingUnionFindTest methodsFor: 'testing - enumerating' stamp: 'fbs 1/14/2012 10:45'!
testVarsInjectIntoIteratesOverVariables
	| mgu vars |
	mgu := VariableTrackingUnionFind
		usingArrayType: PersistentCollection
		partitioning: Dictionary new.
	mgu := mgu union: #x asVariable with: 1.
	mgu := mgu union: #z asVariable with: 1.
	mgu := mgu union: #y asVariable with: 2.
	vars := mgu varsInject: Set new into: [:acc :var | acc , {var}].
	self assert: {#x asVariable. #y asVariable. #z asVariable} asSet equals: vars.! !

!VariableTrackingUnionFindTest methodsFor: 'testing - enumerating' stamp: 'fbs 1/13/2012 18:51'!
testVarsInjectIntoOverEmptyVariableCollectionDoesNothing
	| mgu vars |
	mgu := VariableTrackingUnionFind
		usingArrayType: PersistentCollection
		partitioning: Dictionary new.
	vars := mgu varsInject: #() into: [:acc :var | acc , var].
	self assert: #() equals: vars.! !
