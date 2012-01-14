PersistentUnionFind subclass: #VariableTrackingUnionFind
	instanceVariableNames: 'vars'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!VariableTrackingUnionFind commentStamp: 'fbs 1/4/2012 20:42' prior: 0!
A VariableAvoidingUnionFind is a persistent union-find structure that also tracks MetaVariables.

In particular, it maintains the invariants of a _schema function_ mapping equivalence classes to terms: a schema function S is a function such that
* S(C) elem C,
* S(C) is a MetaVariable only if every element in C is a MetaVariable.!


!VariableTrackingUnionFind methodsFor: 'accessing' stamp: 'fbs 1/4/2012 13:31'!
at: anObject addVar: aMetaVariable
	| representative |
	representative := self find: anObject.
	^ vars at: representative put: ((vars at: representative) , {aMetaVariable})! !

!VariableTrackingUnionFind methodsFor: 'accessing' stamp: 'fbs 1/3/2012 16:01'!
varsAt: anObject
	^ vars at: anObject! !


!VariableTrackingUnionFind methodsFor: 'enumerating' stamp: 'fbs 1/13/2012 18:59'!
varsInject: initialValue into: binaryBlock
	^ (vars inject: Set new into: [:allVars :theseVars | allVars , theseVars])
		inject: initialValue into: binaryBlock.! !


!VariableTrackingUnionFind methodsFor: 'initialize-release' stamp: 'fbs 1/3/2012 16:10'!
initialize
	super initialize.
	vars := PersistentCollection initially: (DictionaryWithDefault wrapping: Dictionary new default: [:unused | Set new]).! !


!VariableTrackingUnionFind methodsFor: 'private' stamp: 'fbs 1/3/2012 16:02'!
copyWithRanks: anArray parents: anotherArray
	^ self class new ranks: anArray parents: anotherArray vars: vars.! !

!VariableTrackingUnionFind methodsFor: 'private' stamp: 'fbs 1/3/2012 16:03'!
ranks: anArray parents: anotherArray vars: aThirdArray
	super ranks: anArray parents: anotherArray.
	vars := aThirdArray.! !

!VariableTrackingUnionFind methodsFor: 'private' stamp: 'fbs 1/4/2012 16:28'!
storeSchemaTermFor: anObject as: anotherObject
	"The schema function is a function from terms to equivalence classes such that:
	* sigma(C) elem C,
	* sigma(C) is a variable only if every c in C is a variable."
	(anObject isMetaVariable and: [anotherObject isMetaVariable])
		ifTrue:
			[vars := self at: anotherObject addVar: anObject.
			^ super storeSchemaTermFor: anObject as: anotherObject].

	anotherObject isMetaVariable
		ifTrue:
			[vars := self at: anObject addVar: anotherObject.
			^ super storeSchemaTermFor: anotherObject as: anObject].

	anObject isMetaVariable
		ifTrue:
			[vars := self at: anotherObject addVar: anObject].
	^ super storeSchemaTermFor: anObject as: anotherObject.! !
