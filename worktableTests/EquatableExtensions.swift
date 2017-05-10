import XCTest


extension Equatable {

	func assert<T>(
		equal expected: T,
		_ message: @autoclosure () -> String = String(),
		file: StaticString = #file,
		line: UInt = #line
		) where T: Equatable {
		guard let casted = expected as? Self
		else {
			let guardMessage = "equatable.assert(equal:) failed: Cannot cast parameter \"\(expected)\" into Self"
			XCTFail("\(guardMessage) - \(message())", file: file, line: line)
			return
		}

		if self != casted  {
			XCTFail(message(), file: file, line: line)
		}
	}

}

