import XCTest


extension Array {

	func assert(
		count: IndexDistance,
		_ message: @autoclosure () -> String = String(),
		file: StaticString = #file,
		line: UInt = #line
	) {
		XCTAssertEqual(self.count, count, message(), file: file, line: line)
	}

}


extension Array where Element: Equatable {

	func assert(
		equal: Array,
		_ message: @autoclosure () -> String = String(),
		file: StaticString = #file,
		line: UInt = #line
	) {
		XCTAssertEqual(self, equal, message(), file: file, line: line)
	}

}
