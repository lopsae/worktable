

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
