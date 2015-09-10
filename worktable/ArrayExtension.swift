

extension Array {

	var tail: T? {
		get {
			return last
		}

		mutating set(newTail) {
			if count == 0 {
				append(newTail!)
			} else {
				self[count - 1] = newTail!
			}
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
