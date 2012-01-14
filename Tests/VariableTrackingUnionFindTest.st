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
