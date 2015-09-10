

extension Array {

	mutating func setFirst(newFirst: T) {
		if isEmpty {
			append(newFirst)
		} else {
			self[0] = newFirst
		}
	}


	mutating func setLast(newLast: T) {
		if isEmpty {
			append(newLast)
		} else {
			self[count - 1] = newLast
		}
	}


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


	mutating func fill(to index: Int, filler: T) {
		while count <= index {
			append(filler)
		}
	}

}
