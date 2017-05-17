import XCTest


extension Equatable {

	// TODO document reminder of why assert(equals:) needs to exists both here and in optional
	func assert<T>(
		equals expected: T?,
		_ message: @autoclosure () -> String = String(),
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

