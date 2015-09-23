import XCTest


class Counter {

	private(set)
	var count: Int = 0


	func increment() {
		count++
	}


	func reset() {
		count = 0
	}


	func assertCount(expected: Int, reset: Bool = true) {
		XCTAssertEqual(count, expected)
		if reset {
			self.reset()
		}
	}


	func wrapIncrement<Return>(f: () -> Return) -> () -> Return {
		return {
			[weak self] in
			self?.increment()
			return f()
		}
	}


	func wrapIncrement<Param, Return>(f: Param -> Return) -> Param -> Return {
		return {
			[weak self]
			param in
			self?.increment()
			return f(param)
		}
	}

}
