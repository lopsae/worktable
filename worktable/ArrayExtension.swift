import Foundation


extension Array {

	/// Overwrites the first element of the array with the `newFirst` element.
	/// If the array is empty the `newFirst` element is appended.
	mutating func setFirst(newFirst: Element) {
		if isEmpty {
			append(newFirst)
		} else {
			self[0] = newFirst
		}
	}


	/// Overwrites the last element of the array with the `newLast` element. If
	/// the array is empty the `newFirst` element is appended.
	mutating func setLast(newLast: Element) {
		if isEmpty {
			append(newLast)
		} else {
			self[count - 1] = newLast
		}
	}


	/// Returns or sets the element at the `index` position if it exists,
	/// otherwise the array is filled with the `filler` element as as needed
	/// until the element in the `index` position can be returned or set.
	///
	/// Notice that `filler` is automatically captured as a closure which is
	/// called as each `filler` element is created.
	///
	/// When getting — returns the the element at the `index` if it exists,
	/// otherwise the array is filled with `filler` elements up to the `index`
	/// position and the last `filler` element is returned.
	///
	/// When setting — overwrites the element at the `index` position if it
	/// exists, otherwise the array is filled with `filler` elements until
	/// the `newValue` element can be appended at the `index` position.
	subscript(index: Int, @autoclosure filler filler: () -> Element) -> Element {
		mutating get {
			fill(to: index, filler: {_ in filler()})
			return self[index]
		}

		mutating set {
			fill(to: index - 1, filler: {_ in filler()})
			if count > index {
				self[index] = newValue
			} else {
				append(newValue)
			}
			self[index] = newValue
		}
	}


	/// Returns or sets the element at the `index` position if it exists,
	/// otherwise the array is filled with the elements returned by the `filler`
	/// closure as as needed until the element in the `index` position can be
	/// returned or set.
	///
	/// The `filler` closure receives the index where the returned element will
	/// be stored.
	///
	/// When reading — returns the the element at the `index` if it exists,
	/// otherwise the array is filled with the elements returned by the `filler`
	/// closure up to the `index` position and the last `filler` element is
	/// returned.
	///
	/// When writing — overwrites the element at the `index` position if it
	/// exists, otherwise the array is filled with the elements returned by the
	/// `filler` closure until the `newValue` element can be appended at the
	/// `index` position.
	subscript(index: Int, @noescape filler filler: Int -> Element) -> Element {
		mutating get {
			fill(to: index, filler: filler)
			return self[index]
		}

		mutating set {
			fill(to: index - 1, filler: filler)
			if count > index {
				self[index] = newValue
			} else {
				append(newValue)
			}
		}
	}


	/// Fills the array up to the `index` position with the `filler` element.
	///
	/// Notice that `filler` is automatically captured as a closure which is
	/// called as each `filler` element is created.
	///
	/// If the array already contains more elements that the `to` index then no
	/// operation is performed.
	mutating func fill(to fillIndex: Int, @autoclosure filler: () -> Element) {
		while count <= fillIndex {
			append(filler())
		}
	}


	/// Fills the array up to the `index` position with the elements returned by
	/// the `filler` closure.
	///
	/// If the array already contains more elements that the `to` index then no
	/// operation is performed.
	mutating func fill(to fillIndex: Int, @noescape filler: Int -> Element) {
		if count > fillIndex {
			return
		}

		for index in count...fillIndex {
			append(filler(index))
		}
	}

}
