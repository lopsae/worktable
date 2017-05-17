import XCTest


class AssertsTests: XCTestCase {

	// TODO add lots of tests to try all these combinations
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

		// optional-nil equals optional nil
		maybe = nil
		maybe.assert(equals: maybe)

		// optional-nil equals literal-nil
		maybe.assert(equals: nil)
	}


	func testImpossibleEquals() {
		// Empty, to remember other impossible cases

		// optional-nil equals equatable
		// invalid, would never be equal

		// literal-nil equals optional
		// not valid, cannot infer type from `nil`
		// nil.assert(equals: maybe)

		// literal-nil equals literal-nil
		// invalid, cannot infer type from `nil`
		// nil.assert(equals: nil)
	}


	func testOptionalsNil() {
		var maybe: String? = "test"
		maybe.assertNotNil()

		maybe = nil
		maybe.assertNil()
	}


}

