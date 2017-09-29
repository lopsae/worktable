import XCTest


struct Assertion {

  let isSuccess: Bool
  let description: String
  let file: StaticString
  let line: UInt


  init(
    assert: Bool,
    description: String,
    file: StaticString,
    line: UInt
  ) {
    isSuccess = assert
    self.description = description
    self.file = file
    self.line = line
  }


  var isFailure: Bool {
    return !isSuccess
  }


  func run(
    _ message: @autoclosure () -> String = .empty,
    function: StaticString
    ) {
    if isSuccess { return }

    XCTFail("\(function) failed: \(description) - \(message())", file: file, line: line)
  }


  func assertSuccess(
    _ message: @autoclosure () -> String = .empty,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    if isFailure {
      XCTFail("Assertion.assert() failed - \(message())", file: file, line: line)
    }
  }


  func assertFailure(
    _ message: @autoclosure () -> String = .empty,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    if isSuccess {
      XCTFail("Assertion.assertFailure() failed - \(message())", file: file, line: line)
    }
  }

}

