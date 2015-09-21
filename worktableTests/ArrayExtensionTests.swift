import XCTest


class ArrayExtension: XCTestCase {

	var tester: [String] = []
	var element: String? = nil
	var timesCalled = 0


	override func setUp() {
		super.setUp()
		tester = []
		element = nil
		timesCalled = 0
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
		tester.fill(to: 0) {_ in
			self.timesCalled++
			return "once"
		}
		XCTAssertEqual(tester, ["once"])
		XCTAssertEqual(timesCalled, 1)
		timesCalled = 0

		tester.fill(to: 2) {_ in
			self.timesCalled++
			return "twice"
		}
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		XCTAssertEqual(timesCalled, 2)
		timesCalled = 0

		tester.fill(to: 1) {_ in
			self.timesCalled++
			return "none"
		}
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		XCTAssertEqual(timesCalled, 0)

		tester.fill(to: 2) {_ in
			self.timesCalled++
			return "none"
		}
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		XCTAssertEqual(timesCalled, 0)
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
		element = tester[1, filler: {_ in
			self.timesCalled++
			return "first"
		}]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "first"])
		XCTAssertEqual(timesCalled, 2)
		timesCalled = 0

		tester[1, filler: {_ in
			self.timesCalled++
			return "none"
		}] = "second"
		XCTAssertEqual(tester, ["first", "second"])
		XCTAssertEqual(timesCalled, 0)

		element = tester[2, filler: {_ in
			self.timesCalled++
			return "third"
		}]
		XCTAssertEqual(element, "third")
		XCTAssertEqual(tester, ["first", "second", "third"])
		XCTAssertEqual(timesCalled, 1)
		timesCalled = 0

		element = tester[0, filler: {_ in
			self.timesCalled++
			return "none"
		}]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "second", "third"])
		XCTAssertEqual(timesCalled, 0)

		tester[4, filler: {_ in
			self.timesCalled++
			return "fourth"
		}] = "fifth"
		XCTAssertEqual(tester, ["first", "second", "third", "fourth", "fifth"])
		XCTAssertEqual(timesCalled, 1)
		timesCalled = 0
	}

}
