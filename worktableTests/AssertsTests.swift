import XCTest


class AssertsTests: XCTestCase {

	// TODO add lots of tests to try all these combinations
	func testEquatableEquals() {
		// equatable equals equatable
		let string = "test"
		string.assert(equal: "test")

		// equatable equals optional

		// equatable equals optional

		// equatable equals nil

		// optional equals equatable

		// optional equals optional

		// optional equals nil

		// nil equals equatable

		// nil equals optional

		// nil equals nil
	}

	func testOptionalEquals() {
		
	}
	
}

