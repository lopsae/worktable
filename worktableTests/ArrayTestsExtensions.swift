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


	@discardableResult
	func assert<T>(
		allElementsAre _: T.Type,
		_ message: @autoclosure () -> String = .empty,
		file: StaticString = #file,
		line: UInt = #line
	) -> [T]? {
		XCTAssertFalse(isEmpty, "Array::assert(allElementsAre:) failed: empty array always fails assert - \(message())")
		for element in self {
			guard element is T else {
				XCTFail("Array::assert(allElementsAre:) failed: found element (\"\(element)\") not of type (\"\(T.self)\") - \(message())")
				return nil
			}
		}

		return self as? [T]
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
