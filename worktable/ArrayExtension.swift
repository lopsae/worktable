

extension Array {

	/// Overwrites the first element of the array with the `newFirst` element.
	/// If the array is empty the `newFirst` element is appended.
	mutating func setFirst(_ newFirst: Element) {
		if isEmpty {
			append(newFirst)
		} else {
			// TODO use correct indexes
			self[0] = newFirst
		}
	}


	/// Overwrites the last element of the array with the `newLast` element. If
	/// the array is empty the `newFirst` element is appended.
	mutating func setLast(_ newLast: Element) {
		if isEmpty {
			append(newLast)
		} else {
			self[count - 1] = newLast
		}
	}


	// TODO: should return Optional<Any>? it could return Any and have another
	// method to check if the given subindex exists

	/// Returns an element in the given array following the given sequence of 
	/// indexes. The `path` specifies indexes that should be followed: the first
	/// index will retrieve the `instance[index]` element from the instance, if
	/// there are more indexes in the `path`, that element is expected to be an
	/// array and the next index is followed. This continues until the indexes
	/// in `path` are exhausted, in which an element is returned. If at any
	/// point an index cannot be followed then `nil` is returned.
	func follow<IndexPath: RandomAccessCollection>(path: IndexPath) -> Any?
	where IndexPath.Index == Array.Index, IndexPath.Iterator.Element == Array.Index {
		guard path.count > 0 else {
			return nil
		}

		var pathPosition = path.startIndex
		var arrayAtPosition: Array<Any> = self

		while true {
			let currentIndex = path[pathPosition]
			if arrayAtPosition.distance(from: currentIndex, to: arrayAtPosition.endIndex) <= 0 {
				// Out of bounds
				return nil
			}

			let currentElement = arrayAtPosition[currentIndex]
			if path.distance(from: pathPosition, to: path.endIndex) <= 1 {
				// In last position, get item and return
				return currentElement
			}

			// Not last position, have to go deeper
			guard let nextArray = currentElement as? Array<Any> else {
				// No array to go deeper
				return nil
			}

			// Prepare next loop
			pathPosition = path.index(after: pathPosition)
			arrayAtPosition = nextArray
		}
	}


	/**
	Access the element at the `index` position if it exists, otherwise the
	array is filled with the `filler` element as as necesary until the element
	in the `index` position can be accessed.

	- Note: `filler` is captured as an autoclosure that will only be called
	once for each appended element.
	*/
	subscript(index: Index, filler filler: @autoclosure () -> Element) -> Element {
		mutating get {
			let afterIndex = self.index(after: index)
			fill(to: afterIndex, filler: filler())
			return self[index]
		}

		mutating set {
			fill(to: index, filler: filler())
			if count > index {
				self[index] = newValue
			} else {
				append(newValue)
			}
		}
	}


	/**
	Access the element at the `index` position if it exists, otherwise the
	array is filled with elements returned by the `filler` closure until the
	element in the `index` position can be accessed.
	*/
	subscript(index: Index, filler filler: (Index) -> Element) -> Element {
		mutating get {
			let afterIndex = self.index(after: index)
			fill(to: afterIndex, filler: filler)
			return self[index]
		}

		mutating set {
			fill(to: index, filler: filler)
			if count > index {
				self[index] = newValue
			} else {
				append(newValue)
			}
		}
	}


	/**
	Fills the array up to, but not including, the `fillIndex` position with the
	`filler` element.

	No operation is performed if the array already contains `fillIndex`
	elements.

	- Note: `filler` is captured as an autoclosure that will only be called
	once for each appended element.
	*/
	mutating func fill(to fillIndex: Index, filler: @autoclosure () -> Element) {
		while count < fillIndex {
			append(filler())
		}
	}


	/**
	Fills the array up to, but not including, the `fillIndex` position with the
	elements returned by the `filler` closure.
	
	No operation is performed if the array already contains `fillIndex`
	elements.
	*/
	mutating func fill(to fillIndex: Index, filler: (Index) -> Element) {
		if count >= fillIndex {
			return
		}

		for index in count ..< fillIndex {
			append(filler(index))
		}
	}

}
