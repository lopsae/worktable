

protocol OptionalProtocol {

	func isSome() -> Bool
	func isNone() -> Bool
	func unwrap() -> Any

}


extension Optional : OptionalProtocol {

	func isSome() -> Bool {
		switch self {
			case .None: return false
			case .Some: return true
		}
	}


	func isNone() -> Bool {
		switch self {
			case .None: return true
			case .Some: return false
		}
	}


	func unwrap() -> Any {
		switch self {
			case .None: preconditionFailure("nil unwrapped")
			case .Some(let unwrapped): return unwrapped
		}
	}

}