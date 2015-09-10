

extension Array {

	/**
	Overwrites the first element of the array with the `newFirst` element. If
	the array is empty the `newFirst` element is appended.
	*/
	mutating func setFirst(newFirst: T) {
		if isEmpty {
			append(newFirst)
		} else {
			self[0] = newFirst
		}
	}


	/**
	Overwrites the last element of the array with the `newLast` element. If
	the array is empty the `newFirst` element is appended.
	*/
	mutating func setLast(newLast: T) {
		if isEmpty {
			append(newLast)
		} else {
			self[count - 1] = newLast
		}
	}


	/**
	Subscript that fills the array up to a given position and then returns or
	overwrite the content of that position.
	
	For both get and set — if the array count is lower that `index` the array is
	filled up with the `filler` element up the `index` position.
	
	When getting — the subscript will return either the element that was already
	at the `index` position, or will fill up to the `index` position and then
	return the `filler` element.
	
	When setting — the subscript will overwrite the element that was already at
	the `index` position, or will fill up to the `index` position and then set
	the last element with the `newValue` element.
	*/
	subscript(index: Int, #filler: T) -> T {
		mutating get {
			fill(to: index, filler: filler)
			return self[index]
		}

		mutating set(newValue) {
			fill(to: index, filler: filler)
			self[index] = newValue
		}
	}


	/**
	Fills the array to the `index` position with the `filler` element.
	
	If the array count is already greater that `index` no operation is
	performed.
	*/
	mutating func fill(to index: Int, filler: T) {
		while count <= index {
			append(filler)
		}
	}

}
