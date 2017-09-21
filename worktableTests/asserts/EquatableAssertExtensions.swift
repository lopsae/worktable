import XCTest


extension Equatable {

  /**
   Asserts that `self` is equal to `expected`.
   */
  func assert(
    equals expected: Self?,
    _ message: @autoclosure () -> String = .empty,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    XCTAssertEqual(self, expected, file: file, line: line)
  }

}


/**
 Mirror of Equatable assert functions to make them available to Optionals.
 */
extension Optional where Wrapped: Equatable {

  /**
   Asserts that `self` is equal to `expected`.

   TODO: - Note: asserting nil against nil succeeds?
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

