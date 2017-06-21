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


	// TODO: add complete assert params
	func assert<T>(elementIs _: T.Type) {
		XCTAssert(Element.self is T.Type)
	}

}


extension Array where Element: Equatable {

	func assert(
		equals expected: Array,
		_ message: @autoclosure () -> String = String(),
		file: StaticString = #file,
		line: UInt = #line
	) {
		XCTAssertEqual(self, expected, message(), file: file, line: line)
	}

}
