import Foundation


extension Array {

	/**
	Overwrites the first element of the array with the `newFirst` element. If
	the array is empty the `newFirst` element is appended.
	*/
	mutating func setFirst(newFirst: Element) {
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
	mutating func setLast(newLast: Element) {
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
	subscript(index: Int, filler filler: Element) -> Element {
		mutating get {
			fill(to: index, filler: filler)
			return self[index]
		}

		mutating set(newElement) {
			fill(to: index - 1, filler: filler)
			if count > index {
				self[index] = newElement
			} else {
				append(newElement)
			}
			self[index] = newElement
		}
	}


// TODO: docs
	subscript(index: Int, @noescape filler filler: Int -> Element) -> Element {
		mutating get {
			fill(to: index, filler: filler)
			return self[index]
		}

		mutating set(newElement) {
			fill(to: index - 1, filler: filler)
			if count > index {
				self[index] = newElement
			} else {
				append(newElement)
			}
		}
	}


	/**
	Fills the array to the `index` position with the `filler` element.
	
	If the array count is already greater that `index` no operation is
	performed.
	*/
	mutating func fill(to fillIndex: Int, filler: Element) {
		while count <= fillIndex {
			append(filler)
		}
	}


// TODO: docs
	mutating func fill(to fillIndex: Int, @noescape filler: Int -> Element) {
		if count > fillIndex {
			return
		}

		for index in count...fillIndex {
			append(filler(index))
		}
	}

}
