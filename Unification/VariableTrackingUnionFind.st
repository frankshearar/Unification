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

!VariableTrackingUnionFind methodsFor: 'accessing' stamp: 'fbs 1/15/2012 19:01'!
union: anObject with: anotherObject
	| cx cy rx ry |
	cx := self find: anObject.
	cy := self find: anotherObject.
	(cx = cy) ifTrue: [^ self].
	
	rx := ranks at: cx.
	ry := ranks at: cy.
	
	(rx > ry)
		ifTrue: [
			^ self class new ranks: (ranks at: cy put: ry + rx)
				parents: (self storeSchemaTermFor: cy as: cx)
				vars: (self updateVarsFor: cy and: cx)].
		
	^ self class new ranks: (ranks at: cx put: ry + rx)
		parents: (self storeSchemaTermFor: cx as: cy)
		vars: (self updateVarsFor: cx and: cy).! !

!VariableTrackingUnionFind methodsFor: 'accessing' stamp: 'fbs 1/15/2012 20:12'!
variableContainingClasses
	"Return the representatives of those classes containing variables."
	^ vars withValue: [:dict |
		(dict reject: #isEmpty) keys].! !

!VariableTrackingUnionFind methodsFor: 'accessing' stamp: 'fbs 1/3/2012 16:01'!
varsAt: anObject
	^ vars at: anObject! !


!VariableTrackingUnionFind methodsFor: 'enumerating' stamp: 'fbs 1/15/2012 15:34'!
varsInject: initialValue into: binaryBlock
	^ (vars inject: Set new into: [:allVars :theseVars | allVars , theseVars])
		inject: initialValue into: binaryBlock.! !


!VariableTrackingUnionFind methodsFor: 'initialize-release' stamp: 'fbs 1/3/2012 16:10'!
initialize
	super initialize.
	vars := PersistentCollection initially: (DictionaryWithDefault wrapping: Dictionary new default: [:unused | Set new]).! !


!VariableTrackingUnionFind methodsFor: 'private' stamp: 'fbs 1/3/2012 16:03'!
ranks: anArray parents: anotherArray vars: aThirdArray
	super ranks: anArray parents: anotherArray.
	vars := aThirdArray.! !

!VariableTrackingUnionFind methodsFor: 'private' stamp: 'fbs 1/15/2012 21:53'!
storeSchemaTermFor: anObject as: anotherObject
	"The schema function is a function from terms to equivalence classes such that:
	* sigma(C) elem C,
	* sigma(C) is a variable only if every c in C is a variable."
	
	(anObject isMetaVariable and: [anotherObject isMetaVariable])
		ifTrue:
			[^ super storeSchemaTermFor: anObject as: anotherObject].

	anotherObject isMetaVariable
		ifTrue:
			[^ super storeSchemaTermFor: anotherObject as: anObject].

	^ super storeSchemaTermFor: anObject as: anotherObject.! !

!VariableTrackingUnionFind methodsFor: 'private' stamp: 'fbs 1/15/2012 16:16'!
updateVarsFor: anObject and: anotherObject
	"The schema function is a function from terms to equivalence classes such that:
	* sigma(C) elem C,
	* sigma(C) is a variable only if every c in C is a variable."
	(anObject isMetaVariable and: [anotherObject isMetaVariable])
		ifTrue:
			[^ self at: anotherObject addVar: anObject].

	anotherObject isMetaVariable
		ifTrue:
			[^ self at: anObject addVar: anotherObject].

	anObject isMetaVariable
		ifTrue:
			[^ self at: anotherObject addVar: anObject].
		
	^ vars.! !
