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
	Asserts that `expected` is equal to the current count.
	*/
	@discardableResult
	func assertCount(
		_ expected: Int,
	    _ message: @autoclosure () -> String = String(),
	    file: StaticString = #file,
	    line: UInt = #line
	) -> Self {
		XCTAssertEqual(count, expected, message(), file: file, line: line)
		return self
	}


	/**
	Increments the counter and returns the given `delivery`.
	
	- Note:
	Method intended for testing calls of autoclosure parameters.
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
