import XCTest


class ArrayExtension: XCTestCase {

	var tester: [String] = []
	var element: String? = nil


	override func setUp() {
		super.setUp()
		tester = []
		element = nil
	}


	func testSetFirst() {
		// With emtpy array
		tester.setFirst("one")

		XCTAssertEqual(tester.count, 1)
		XCTAssertEqual(tester.first, "one")
		XCTAssertEqual(tester.last, "one")

		// With elements in array
		tester = ["wrong", "two", "three"]
		tester.setFirst("one")
		XCTAssertEqual(tester.count, 3)
		XCTAssertEqual(tester.first, "one")
	}


	func testSetLast() {
		// With emtpy array
		tester.setLast("one")

		XCTAssertEqual(tester.count, 1)
		XCTAssertEqual(tester.first, "one")
		XCTAssertEqual(tester.last, "one")

		// With elements in array
		tester = ["one", "two", "wrong"]
		tester.setLast("three")
		XCTAssertEqual(tester.count, 3)
		XCTAssertEqual(tester.last, "three")
	}


	func testFiller() {
		tester.fill(to: 0, filler: "once")
		XCTAssertEqual(tester, ["once"])

		tester.fill(to: 2, filler: "twice")
		XCTAssertEqual(tester, ["once", "twice", "twice"])

		tester.fill(to: 1, filler: "none")
		XCTAssertEqual(tester, ["once", "twice", "twice"])

		tester.fill(to: 2, filler: "none")
		XCTAssertEqual(tester, ["once", "twice", "twice"])
	}


	func testFillerWithBlock() {
		// TODO: check that the funciton is called correct amount of times
		tester.fill(to: 0) {_ in "once"}
		XCTAssertEqual(tester, ["once"])

		tester.fill(to: 2) {_ in "twice"}
		XCTAssertEqual(tester, ["once", "twice", "twice"])

		tester.fill(to: 1) {_ in "none"}
		XCTAssertEqual(tester, ["once", "twice", "twice"])

		tester.fill(to: 2) {_ in "none"}
		XCTAssertEqual(tester, ["once", "twice", "twice"])
	}


	func testSubscriptFiller() {
		element = tester[1, filler: "first"]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "first"])

		tester[1, filler: "none"] = "second"
		XCTAssertEqual(tester, ["first", "second"])

		element = tester[2, filler: "third"]
		XCTAssertEqual(element, "third")
		XCTAssertEqual(tester, ["first", "second", "third"])

		element = tester[0, filler: "none"]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "second", "third"])

		tester[4, filler: "fourth"] = "fifth"
		XCTAssertEqual(tester, ["first", "second", "third", "fourth", "fifth"])
	}


	func testSubscriptFillerWithBlock() {
		// TODO: check that block is called correct amount of times
		element = tester[1, filler: {_ in "first"}]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "first"])

		tester[1, filler: {_ in "none"}] = "second"
		XCTAssertEqual(tester, ["first", "second"])

		element = tester[2, filler: {_ in "third"}]
		XCTAssertEqual(element, "third")
		XCTAssertEqual(tester, ["first", "second", "third"])

		element = tester[0, filler: {_ in "none"}]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "second", "third"])

		tester[4, filler: {_ in "fourth"}] = "fifth"
		XCTAssertEqual(tester, ["first", "second", "third", "fourth", "fifth"])
	}

}
