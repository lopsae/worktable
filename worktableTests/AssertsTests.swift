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
		// TODO add chaining return to assertNotNil
		maybe.assertNotNil()
	}


	func testOptionalIsType() {
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

		// Assert property but is a misleading case:
		// type(of: maybeControl) returns Any?
		// anything is Any? will always evaluate true
		let maybeControl: Any? = UIControl()
		maybeAny.assert(is: type(of: maybeControl))
		maybeAny.assert(is: Any?.self)
		maybeAny.assert(is: Any.self)

		// For some reason the following does not work
		// cannot invoke assert with list (is: Any.Type)
		// let control: Any = UIControl()
		// maybeAny.assert(is: type(of: control))

		// any optional with struct with generic
		let maybeArray: Any? = ["test"]
		maybeArray.assert(is: [String].self)
		maybeArray.assert(is: type(of: ["string"]))
	}


	func testOptionalIsTypeChaining() {
		// typed optional
		let maybeString: String? = "test"
		maybeString.assert(is: String.self)?
		.assert(equals: "test")

		// any optional with struct with generic
		let maybeArray: Any? = ["test"]
		maybeArray.assert(is: [String].self)?
		.assert(equals: ["test"])

		maybeArray.assert(is: [String].self)?[0]
		.assert(equals: "test")

		// any optional with class
		let button = UIButton()
		button.titleLabel!.text = "testButton"
		button.accessibilityLabel = "testLabel"

		let maybeAny: Any? = button
		maybeAny.assert(is: UIButton.self)?
		.titleLabel!.text.assert(equals: "testButton")

		// any optional class extending
		maybeAny.assert(is: UIControl.self)?
		.accessibilityLabel.assert(equals: "testLabel")
	}


	func testArrayAllElementsAre() {
		let array = ["test"]
		array.assert(allElementsAre: String.self)
		array.assert(allElementsAre: type(of: "string"))

		let arrayOfAny: [Any] = ["test"]
		arrayOfAny.assert(allElementsAre: String.self)
		arrayOfAny.assert(allElementsAre: type(of: "string"))

		// TODO: how to test that an assert fails?
		// have internal method that returns an assert result and that can
		// be checked and raised if necesary? or raised if not expected and all that?
		// let emptyArray: [String] = []
		// emptyArray.assert(elementIs: String.self) // should fail
		// emptyArray.assert(elementIs: type(of: "string")) // should fail
	}


	func testArrayAllElementsAreChaining() {
		let array = ["test"]
		array.assert(allElementsAre: String.self)?
		// TODO: add an chaining assertNotNill here and bellow
		.first!.assert(equals: "test")

		let arrayOfAny: [Any] = ["test"]
		arrayOfAny.assert(allElementsAre: String.self)?
		.first!.assert(equals: "test")
	}



}

