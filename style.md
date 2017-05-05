Style
=====
General rules for documentation.


First sentence for methods
--------------------------
First sentence always start with an simple present verb in which the subject is an ommited "the method".

TODO: its called backtick
Parameter are refered by name in `code formatting`, and usually refered as "the given `parameter`"
TODO: what is a good example of a case that sounds better with "given `parameter`".

> Fills the array up to, but not including, the `fillIndex` position with
the `filler` element.


Conditional clauses
-------------------
In cases where the method operation would vary the result is always stated first followed by "if a reason holds true".

> No operation is performed if the array already contains `fillIndex` elements.

The inverse is discouraged since it leads to more ambiguous reading, and the focus should be in the change of behaviour.

> Discouraged: If the array already contains `fillIndex` elements then no operation is performed.


General verbs
-------------
For getters methods the description should start with "Returns ..."

For setters methods the description should start with "Sets ..."

For getter/setter methods the description should start with "Access ..."