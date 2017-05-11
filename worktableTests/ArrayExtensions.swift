import XCTest


extension Array {

	func assert(
		count expected: IndexDistance,
		_ message: @autoclosure () -> String = String(),
		file: StaticString = #file,
		line: UInt = #line
	) {
		XCTAssertEqual(self.count, expected, message(), file: file, line: line)
	}

}


extension Array where Element: Equatable {

	func assert(
		// TODO rename to equals
		equal expected: Array,
		_ message: @autoclosure () -> String = String(),
		file: StaticString = #file,
		line: UInt = #line
	) {
		XCTAssertEqual(self, expected, message(), file: file, line: line)
	}

}
