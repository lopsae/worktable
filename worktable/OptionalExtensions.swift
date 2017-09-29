

protocol OptionalProtocol {

	func isSome() -> Bool
	func isNone() -> Bool
	func unwrap() -> Any

}


extension Optional : OptionalProtocol {

	func isSome() -> Bool {
		switch self {
			case .none: return false
			case .some: return true
		}
	}


	func isNone() -> Bool {
		switch self {
			case .none: return true
			case .some: return false
		}
	}


	func unwrap() -> Any {
		switch self {
			case .none: preconditionFailure("nil unwrapped")
			case .some(let unwrapped): return unwrapped
		}
	}

}


// MARK:- String representations
extension Optional {

  /**
   Returns the debug description of the wrapped element, otherwise returns
   `nil`.
   */
  var unwrappedDebugDescription: String {
    switch self {
    case .some(let wrapped):
      return String(reflecting: wrapped)
    case .none:
      return String(reflecting: self)
    }
  }

}


// MARK:- Operations with closures
extension Optional {

	/**
	Returns `self` if `self` wraps a value, otherwise returns the result of the
	`ifNil` closure.
	*/
	func coalesce(ifNil: () -> Wrapped) -> Wrapped {
		switch self {
		case .some(let wrapped):
			return wrapped
		case .none:
			return ifNil()
		}
	}


	/**
	Calls the given closure `self` wraps a value, otherwise performs no
	operation. Afterwards in both cases `self` is returned.
	*/
	@discardableResult
	func ifSome(_ closure: (Wrapped) -> Void) -> Optional {
		switch self {
		case .some(let wrapped):
			closure(wrapped)
			return self
		case .none:
			return self
		}
	}

}

