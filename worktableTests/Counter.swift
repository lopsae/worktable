import XCTest


class Counter {

	private(set)
	var count: Int = 0


	func increment() {
		count += 1
	}


	func reset() {
		count = 0
	}


	func assertCount(_ expected: Int, reset: Bool = true) {
		XCTAssertEqual(count, expected)
		if reset {
			self.reset()
		}
	}


	func wrapIncrement<Return>(_ f: @escaping () -> Return) -> () -> Return {
		return {
			[weak self] in
			self?.increment()
			return f()
		}
	}


	func wrapIncrement<Param, Return>(_ f: @escaping (Param) -> Return) -> (Param) -> Return {
		return {
			[weak self]
			param in
			self?.increment()
			return f(param)
		}
	}

}
