import XCTest


extension Optional {

	// TODO define type AutoMessage? MessageClosure

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


	func assert<T>(
		is _: T.Type,
		_ message: @autoclosure () -> String = String(),
		file: StaticString = #file,
		line: UInt = #line
	) {
		// TODO: define a consistent format for messages this is so far best example
		// TODO: figure out how to systematize assert messages
		// TODO: add to style rules about separations of levels with dashes
		// TODO: add to style rules about printing debug values with ("this") format
		let function = #function
		var action = "(\"\(self.debugDescription)\") is never of type (\"\(T.self)\")"
		var assertMessage = "\(function) failed: \(action)"
		assertNotNil("\(assertMessage) - \(message())", file: file, line: line)
		
		guard self != nil else { return }

		action = "(\"\(self.debugDescription)\") is not of type (\"\(T.self)\")"
		assertMessage = "\(function) failed: \(action)"

		// Assert should check `self! is T`, checking for
		// `Wrapped.self is T.type` is incorrect since that would check thei mean
		// type of the optional generic, and not the wrapped object
		XCTAssert(self! is T, "\(assertMessage) - \(message())", file: file, line: line)
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

