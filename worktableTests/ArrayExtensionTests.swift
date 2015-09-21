import XCTest


class ArrayExtension: XCTestCase {

	var tester: [String] = []
	var element: String? = nil
	var counter = Counter()


	override func setUp() {
		super.setUp()
		tester = []
		element = nil
		counter.reset()
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
		tester.fill(to: 0, filler: counter.curryIncrement({_ in "once"}))
		XCTAssertEqual(tester, ["once"])
		counter.assertCount(1)

		tester.fill(to: 2) {
			_ in
			counter.increment()
			return "twice"
		}
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(2)

		tester.fill(to: 1) {
			_ in
			counter.increment()
			return "none"
		}
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(0)

		tester.fill(to: 2){
			_ in
			counter.increment()
			return "none"
		}
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(0)
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
		element = tester[1,
			filler: {_ in
				counter.increment()
				return "first"
			}
		]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "first"])
		counter.assertCount(2)

		tester[1,
			filler: {_ in
				counter.increment()
				return "none"
			}
		] = "second"
		XCTAssertEqual(tester, ["first", "second"])
		counter.assertCount(0)

		element = tester[2,
			filler: {_ in
				counter.increment()
				return "third"
			}
		]
		XCTAssertEqual(element, "third")
		XCTAssertEqual(tester, ["first", "second", "third"])
		counter.assertCount(1)

		element = tester[0,
			filler: {_ in
				counter.increment()
				return "none"
			}
		]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "second", "third"])
		counter.assertCount(0)

		tester[4,
			filler: {_ in
				counter.increment()
				return "fourth"
			}
		] = "fifth"
		XCTAssertEqual(tester, ["first", "second", "third", "fourth", "fifth"])
		counter.assertCount(1)
	}

}
