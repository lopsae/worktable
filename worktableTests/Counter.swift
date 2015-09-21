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


	func curryIncrement<Param, Return>(f: Param -> Return) -> Param -> Return {
		return {
			[weak self]
			(param: Param) -> Return in
			self?.increment()
			return f(param)
		}

	}

}
