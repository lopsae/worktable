import XCTest


extension Optional {

  func assertNil(
    _ message: @autoclosure () -> String = .empty,
    file: StaticString = #file,
    line: UInt = #line
  ) {
    makeAssertNil(file: file, line: line)
      .run(message(), function: #function)
  }


  func makeAssertNil(
    file: StaticString = #file,
    line: UInt = #line,
    function: String? = nil
  ) -> Assertion {
    return Assertion(
      assert: self == nil,
      description: "(\(self.unwrappedDebugDescription)) is not nil",
      file: file,
      line: line
    )
  }


  @discardableResult
  func assertNotNil(
    _ message: @autoclosure () -> String = .empty,
    file: StaticString = #file,
    line: UInt = #line
  ) -> Optional {
    makeAssertNotNil(file: file, line: line)
      .run(message(), function: #function)
    return self
  }


  func makeAssertNotNil(
    file: StaticString = #file,
    line: UInt = #line,
    function: String? = nil
  ) -> Assertion {
    return Assertion(
      assert: self != nil,
      description: "self is nil",
      file: file,
      line: line
    )
  }


  @discardableResult
  func assert<T>(
    is _: T.Type,
    _ message: @autoclosure () -> String = .empty,
    file: StaticString = #file,
    line: UInt = #line
  ) -> T? {
    // TODO: figure out how to systematize assert messages
    let signature = "\(type(of: self))::\(#function)"
    var action = "(\"\(self.debugDescription)\") is never of type (\"\(T.self)\")"
    var assertMessage = "\(signature) failed: \(action)"
    assertNotNil("\(assertMessage) - \(message())", file: file, line: line)
    // TODO: this assert message outputs: XCTAssertTrue failed - assert(is:_:file:line:) failed: ("value")...
    // which is confusing since it comes from this method: assert(is:
    // seems like XCTFail is the only method that does not print method name, since it prints: failed - assert message
    // so probably all custom assert methods should be calling XCTFail to provide clean asert messages

    // TODO: This assert ultimately should be printing:
    // failed - Optional<Wrapped.self>::assert(is:) failed: ("self") is not of type ("T.self") - message

    guard self != nil else {
      return nil
    }

    action = "(\"\(self.debugDescription)\") is not of type (\"\(T.self)\")"
    assertMessage = "\(signature) failed: \(action)"

    // Assert must check `self! is T`, checking for
    // `Wrapped.self is T.type` is incorrect since that would check the type
    // of the generic variable or constant, and not the wrapped object
    XCTAssert(self! is T, "\(assertMessage) - \(message())", file: file, line: line)
    
    return self! as? T ?? nil
  }
  
}

