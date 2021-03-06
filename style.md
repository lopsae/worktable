Style
=====
General rules for documentation.


Method descriptions
-------------------
First sentence of a method description always start with an simple present verb in which the subject is an ommited "The method", for example "[The method] fills up the array...":

> Fills the array up to, but not including, the `fillIndex` position with
the `filler` element.



Parameters names in descriptions
--------------------------------
Parameters are referred by name in code formatting by surrounding with backticks.

> Increments the counter and returns the given `delivery`.

When the parameter name is used as a independent noun it is usually preceded by "the given `parameter`". Omit "the given" if it reads repetitive or if the parameter name is descriptive enough that it reads properly on its own. Using "the `parameter`" is generaly discouraged.

> Returns the given `string` and increases `counter` once.

When the parameter name is used as a modifier of another noun use it in the form of "the `parameter` noun".
TODO: is "modifier" and "independent" correct terms?

> Overwrites the first element of the array with the `newFirst` element.



Conditional clauses
-------------------
In cases where the method operation would vary the result is always stated first followed by "if a reason holds true".

> No operation is performed if the array already contains `fillIndex` elements.

The inverse is discouraged since the focus should be in the change of behaviour and it leads to more ambiguous reading.

> Discouraged:
> If the array already contains `fillIndex` elements then no operation is performed.

In cases where more detail is added for the return value "Also returns..." can be used in order to avoid repetition.

> Also returns `nil` if `self` is NaN or positive infinity.



General verbs
-------------
For getters methods the description should start with "Returns ..."

For setters methods the description should start with "Sets ..."

For getter/setter methods the description should start with "Access ..."

For methods that primarily call a closure the description should start with "Calls ..."



Assert messages
---------------
The default XCTAssert outputs give the following characteristics:

### Method name
The assert method that raised the failure is printed in the output. All XCTAssert methods follow this pattern except XCTFail:

> `XCTAssert(false)` prints:
> `XCTAssertTrue failed -`
> `XCTFail()` prints:
> `failed -`

### Dashes
XCTAssert uses dashes to separate the message related to the assert from the message parameter provided to the assert:

> `XCTAssert(false, "false will fail")` prints:
> `XCTAssertTrue failed - false will fail`

### Information and parameters
Additional information is printed after a colon. Parameters are printed as their debug representation between parenthesis and quotes:

> `XCTAssertEqual("some", "none", "not like the other")` prints:
> `XCTAssertEqual failed: ("some") is not equal to ("none") - not like the other

### Custom Messages

Messages from custom asserts should:
+ User `XCTFail()` to output a cleaner message.
+ Print the method signature that raised the failure, the parameters including `message` and onwards should be omitted.
+ Print the type name if the assert belongs to an instance.
+ Print debug descriptions of parameters when available.

> `maybeButton.assert(is: String.self, "a button is not a string")` should print:
> `failed - Optional<Any>::assert(is:) failed: ("Optional(<UIButton:...>)") is not of type ("String") - a button is not a string



TODOs
-----

TODO: add note about verb tenses in parameters
optional.assert(equals expected:) // `equals` because it reads "assert that optional equals expected"
array.assert(count expected:) // `count` because that is the name of the property to check, and reads "assert array's count property"

TODO: MUST clauses, examples:

The `delegate` of a UICollectionView using a ColumnWaterfallLayout MUST implement this protocol.

The `delegate` of a UICollectionView MUST implement this protocol in order to use a ColumnWaterfallLayout.

This method MUST be called at least once before the instance is used.

Favorite:
This protocol MUST be implemented by the `delegate` of the UICollectionView in order to use a ColumnWaterfallLayout.

It is required that the delegate object used by the UICollectionView using this layout implements this protocol.

TODO verbs after `otherwise` should have the same tense as initial verbs
> Calls the given closure and returns `self` if `self` wraps a value, otherwise performs no operation and returns `self`.

even if the second verb is also `returns`.
> Returns `self` if `self` wraps a value, otherwise returns the result of the `ifNil` closure.