Object subclass: #MostGeneralUnifier
	instanceVariableNames: 'dict'
	classVariableNames: 'EmptyMGU'
	poolDictionaries: ''
	category: 'Unification'!
!MostGeneralUnifier commentStamp: 'fbs 5/2/2012 09:49' prior: 0!
Given two structures s and t, each containing zero or more MetaVariables, to what values must those variables be set for s and t to be structurally equivalent?

If s := 1 and t := #x asVariable, then the most general unifier (mgu) will be {#x asVariable -> 1}.

If s := 2 and t := 1 then the mgu does not exist, and unification will raise a UnificationFailure.

If s := t := 1 then the mgu is {}, or "there's no unification needed".!


!MostGeneralUnifier methodsFor: 'accessing' stamp: 'fbs 1/12/2012 18:43'!
at: key
	^ dict at: key.! !

!MostGeneralUnifier methodsFor: 'accessing' stamp: 'fbs 1/12/2012 09:47'!
at: key put: value
	^ self class newFromPairs: (self asArray , {key. value}).! !

!MostGeneralUnifier methodsFor: 'accessing' stamp: 'fbs 1/12/2012 18:46'!
size
	^ dict size.! !


!MostGeneralUnifier methodsFor: 'adding' stamp: 'fbs 5/2/2012 10:07'!
addAll: anMGU <MostGeneralUnifier>
	"Add all key->values in anMGU and self to a new MGU. When x->y and y->k (x, y MetaVariables) add x->k and y->k instead."
	| newMapping twoStepVariables |
	newMapping := Dictionary newFromPairs: self asArray.
	anMGU keys do: [:k |
		newMapping
			at: k
			ifPresent: [:v | MostGeneralUnifierMergeFailure  signal: ('{1} is already bound to {2}' format: {k. v})]
			ifAbsent: [newMapping at: k put: (anMGU at: k)]].
	
	twoStepVariables := (self values intersection: anMGU keys).
	"'Flatten' two-step mappings from x->y and y->k to x->k and y->k"
	twoStepVariables do: [:y |
		(self keysMappingTo: y) do: [:x | newMapping at: x put: (anMGU at: y)]].
	^ self class newFromPairs: (self asArray: newMapping).! !


!MostGeneralUnifier methodsFor: 'comparing' stamp: 'fbs 1/12/2012 19:16'!
= anMGU
	(anMGU isKindOf: self class) ifFalse: [^ false].
	^ self asArray = anMGU asArray.! !


!MostGeneralUnifier methodsFor: 'converting' stamp: 'fbs 2/10/2012 20:32'!
asArray
	^ self asArray: dict.! !

!MostGeneralUnifier methodsFor: 'converting' stamp: 'fbs 5/2/2012 09:52'!
asArray: aDictionary
	"Answer an Array whose elements are the elements of the receiver.
	Implementation note: Cannot use ''Array withAll: self'' as that only
	works for SequenceableCollections that support the replacement 
	primitive."

	| array index |
	array := Array new: (aDictionary size * 2).
	index := 0.
	aDictionary associationsDo: [:each |
		array at: (index := index + 1) put: each key.
		array at: (index := index + 1) put: each value.].
	^ array! !


!MostGeneralUnifier methodsFor: 'enumerating' stamp: 'fbs 1/12/2012 18:45'!
associationsDo: aBlock 
	"Evaluate aBlock for each of the receiver's elements (key/value 
	associations)."
	^ dict associationsDo: aBlock.! !

!MostGeneralUnifier methodsFor: 'enumerating' stamp: 'fbs 2/10/2012 14:51'!
keys
	^ dict keys.! !

!MostGeneralUnifier methodsFor: 'enumerating' stamp: 'fbs 2/10/2012 15:03'!
keysMappingTo: anObject
	^ dict keys select: [:k | (self at: k) == anObject].! !

!MostGeneralUnifier methodsFor: 'enumerating' stamp: 'fbs 2/10/2012 14:51'!
values
	^ dict values.! !


!MostGeneralUnifier methodsFor: 'printing' stamp: 'fbs 1/12/2012 19:09'!
printOn: aStream
	aStream
		nextPutAll: self class name.
	dict printElementsOn: aStream.! !


!MostGeneralUnifier methodsFor: 'testing' stamp: 'fbs 1/12/2012 18:50'!
includesKey: anObject
	^ dict includesKey: anObject.! !

!MostGeneralUnifier methodsFor: 'testing' stamp: 'fbs 1/12/2012 19:12'!
isEmpty
	^ dict isEmpty.! !


!MostGeneralUnifier methodsFor: 'private' stamp: 'fbs 1/12/2012 18:43'!
wrappingDictionary: aDictionary
	dict := aDictionary.! !


!MostGeneralUnifier methodsFor: 'running' stamp: 'fbs 6/14/2012 09:16'!
member: anObject of: someObjects
	^ self addAll: ([(HeadUnifier value: anObject) unifyWith: someObjects]
		on: UnificationFailure do:
			[[((HeadUnifier value: anObject) | #tail asVariable) unifyWith: someObjects]
				on: UnificationFailure do: [self]])! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

MostGeneralUnifier class
	instanceVariableNames: ''!

!MostGeneralUnifier class methodsFor: 'instance creation' stamp: 'fbs 5/2/2012 16:46'!
empty
	"A well-known object representing the empty most general unifier."
	^ EmptyMGU.! !

!MostGeneralUnifier class methodsFor: 'instance creation' stamp: 'fbs 1/12/2012 18:47'!
new
	^ self basicNew wrappingDictionary: Dictionary new.! !

!MostGeneralUnifier class methodsFor: 'instance creation' stamp: 'fbs 1/12/2012 19:15'!
newFrom: someAssociations
	^ self new wrappingDictionary: (Dictionary newFrom: someAssociations).! !

!MostGeneralUnifier class methodsFor: 'instance creation' stamp: 'fbs 1/12/2012 18:43'!
newFromPairs: anArray 
	"Answer an instance of me associating (anArray at:i) to (anArray at: i+1)
	 for each odd i.  anArray must have an even number of entries."

	^ self new wrappingDictionary: (Dictionary newFromPairs: anArray).! !


!MostGeneralUnifier class methodsFor: 'class initialization' stamp: 'fbs 5/2/2012 16:46'!
initialize
	EmptyMGU := self new.! !


MostGeneralUnifier initialize!
