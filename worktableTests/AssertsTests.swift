import XCTest


class AssertsTests: XCTestCase {

	func testEquatableEquals() {
		// equatable equals equatable
		let string = "test"
		string.assert(equals: "test")

		// equatable equals optional
		let maybe: String? = "test"
		string.assert(equals: maybe)

		// equatable equals nil
		// invalid, would never be equal
	}


	func testOptionalEquals() {
		// optional equals equatable
		var maybe: String? = "test"
		maybe.assert(equals: "test")

		// optional equals optional
		maybe.assert(equals: maybe)

		// optional-nil equals optional-nil
		maybe = nil
		maybe.assert(equals: maybe)

		// optional-nil equals literal-nil
		maybe.assert(equals: nil)
	}


	func testImpossibleEquals() {
		// Empty method, to remember other impossible cases

		// optional-nil equals equatable
		// invalid, would never be equal

		// literal-nil equals optional
		// invalid, cannot infer type from `nil`
		// nil.assert(equals: maybe)

		// literal-nil equals literal-nil
		// invalid, cannot infer type from `nil`
		// nil.assert(equals: nil)
	}


	func testOptionalsNil() {
		var maybe: String?
		maybe.assertNil()

		maybe = "test"
		maybe.assertNotNil()
	}


	func testOptionalType() {
		// typed optional
		let maybeString: String? = "test"
		maybeString.assert(is: String.self)
		maybeString.assert(is: type(of: "string"))

		// typed optional for protocol
		maybeString.assert(is: TextOutputStream.self)

		// any optional with class
		let maybeAny: Any? = UIButton()
		maybeAny.assert(is: UIButton.self)
		maybeAny.assert(is: type(of: UIButton()))

		// any optional class extending
		maybeAny.assert(is: UIControl.self)
		maybeAny.assert(is: type(of: UIControl()))

		let maybeControl: Any? = UIControl()
		maybeAny.assert(is: type(of: maybeControl))

		// Does not work because `Any.Type` cannot be used in the assert
		// and the type of control cannot be inferred on compile time
		// The type to check must be available at compile time
		// let control: Any = UIControl()
		// maybeAny.assert(is: type(of: control))

		// any optional with struct with generic
		let maybeArray: Any? = ["test"]
		maybeArray.assert(is: [String].self)
		maybeArray.assert(is: type(of: ["string"]))
	}


	func testArray() {
		let array = ["test"]
		array.assert(elementIs: String.self)
		array.assert(elementIs: type(of: "string"))

		let emptyArray: [String] = []
		emptyArray.assert(elementIs: String.self)
		emptyArray.assert(elementIs: type(of: "string"))

		// TODO: assert(elementIs: is checking for the type of the array, not for the type of the contained elements
		// rename? is actually what is wanted?
//		let arrayOfAny: [Any] = ["test"]
//		arrayOfAny.assert(elementIs: String.self)
	}





}

