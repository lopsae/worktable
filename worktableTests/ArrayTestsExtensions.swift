import XCTest


extension Array {

	func assert(
		count expected: IndexDistance,
		_ message: @autoclosure () -> String = .empty,
		file: StaticString = #file,
		line: UInt = #line
	) {
		XCTAssertEqual(self.count, expected, message(), file: file, line: line)
	}


	func assert<T>(
		elementIs _: T.Type,
		_ message: @autoclosure () -> String = .empty,
		file: StaticString = #file,
		line: UInt = #line
	) {
		// TODO: do we want to check this or check against the contents of the array?
		XCTAssert(Element.self is T.Type)
	}

}


extension Array where Element: Equatable {

	func assert(
		equals expected: Array,
		_ message: @autoclosure () -> String = .empty,
		file: StaticString = #file,
		line: UInt = #line
	) {
		XCTAssertEqual(self, expected, message(), file: file, line: line)
	}

}
