import XCTest


extension Equatable {

	/**
	Assert that `self` is equal to `expected`.
	*/
	func assert(
		equals expected: Self?,
		_ message: @autoclosure () -> String = .empty,
		file: StaticString = #file,
		line: UInt = #line
	) where T: Equatable {
		guard let casted = expected as? Self
		else {
			let guardMessage = "equatable.assert(equal:) failed: Cannot cast parameter \"\(expected.debugDescription)\" into Self"
			XCTFail("\(guardMessage) - \(message())", file: file, line: line)
			return
		}

		XCTAssertEqual(self, casted, message(), file: file, line: line)
	}

}


/**
Mirror Equatable assert functions to make them available to Optionals.
*/
extension Optional where Wrapped: Equatable {

	/**
	Assert that `self` is equal to `expected`.
	*/
	func assert(
		equals expected: Optional,
		_ message: @autoclosure () -> String = .empty,
		file: StaticString = #file,
		line: UInt = #line
		) {
		XCTAssertEqual(self, expected, message(), file: file, line: line)
	}

}

