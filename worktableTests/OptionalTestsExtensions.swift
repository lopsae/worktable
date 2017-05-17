import XCTest


extension Optional {

	func assertNil(
		_ message: @autoclosure () -> String = String(),
		file: StaticString = #file,
		line: UInt = #line
		) {
		XCTAssertNil(self, message(), file: file, line: line)
	}


	func assertNotNil(
		_ message: @autoclosure () -> String = String(),
		file: StaticString = #file,
		line: UInt = #line
		) {
		XCTAssertNotNil(self, message(), file: file, line: line)
	}

}


extension Optional where Wrapped: Equatable {

	func assert(
		equals expected: Optional,
		_ message: @autoclosure () -> String = String(),
		file: StaticString = #file,
		line: UInt = #line
	) {
		XCTAssertEqual(self, expected, message(), file: file, line: line)
	}

}

