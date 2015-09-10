

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
			while count <= index {
				append(filler)
			}
			return self[index]
		}

		mutating set(newValue) {
			while count <= index {
				append(filler)
			}
			self[index] = newValue
		}
	}

}
