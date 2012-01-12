Object subclass: #MostGeneralUnifier
	instanceVariableNames: 'dict'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Unification'!
!MostGeneralUnifier commentStamp: 'fbs 1/4/2012 10:31' prior: 0!
Given two structures s and t, each containing zero or more MetaVariables, to what values must those variables be set for s and t to be structurally equivalent?

If s := 1 and t := #x asVariable, then the most general unifier (mgu) will be {#x asVariable -> 1}.

If s := 2 and t := 1 then the mgu does not exist.

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


!MostGeneralUnifier methodsFor: 'adding' stamp: 'fbs 1/12/2012 09:28'!
addAll: anMGU
	^ self class newFromPairs: (self asArray , anMGU asArray).! !


!MostGeneralUnifier methodsFor: 'comparing' stamp: 'fbs 1/12/2012 19:16'!
= anMGU
	(anMGU isKindOf: self class) ifFalse: [^ false].
	^ self asArray = anMGU asArray.! !


!MostGeneralUnifier methodsFor: 'converting' stamp: 'fbs 1/12/2012 09:27'!
asArray
	"Answer an Array whose elements are the elements of the receiver.
	Implementation note: Cannot use ''Array withAll: self'' as that only
	works for SequenceableCollections which support the replacement 
	primitive."

	| array index |
	array := Array new: (self size * 2).
	index := 0.
	self associationsDo: [:each |
		array at: (index := index + 1) put: each key.
		array at: (index := index + 1) put: each value.].
	^ array! !


!MostGeneralUnifier methodsFor: 'enumerating' stamp: 'fbs 1/12/2012 18:45'!
associationsDo: aBlock 
	"Evaluate aBlock for each of the receiver's elements (key/value 
	associations)."
	^ dict associationsDo: aBlock.! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

MostGeneralUnifier class
	instanceVariableNames: ''!

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
