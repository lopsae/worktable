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


	/**
	Asserts `expected` is equal to the current count, and by default resets the
	instance.
	*/
	func assertCount(
		_ expected: Int,
	    reset: Bool = true,
	    _ message: @autoclosure () -> String = String(),
	    file: StaticString = #file,
	    line: UInt = #line
	) {
		XCTAssertEqual(count, expected, message(), file: file, line: line)
		if reset {
			self.reset()
		}
	}


	/**
	Increments the counter and returns the given `delivery`.
	
	- Note:
	This method is useful for testing that `autoclosure` parameters get called
	only as necessary.
	*/
	func deliver<Return>(_ delivery: Return) -> Return {
		increment()
		return delivery
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
