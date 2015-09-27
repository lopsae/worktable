import XCTest
import Foundation


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


	/**
	Convenience function to easily call filler functions by just providing the
	filler string to return. Each call to the returned function will also call
	`counter.increase()` once.
	*/
	func mockFiller(filler: String) -> Int -> String {
		return counter.wrapIncrement(){
			(_: Int) in
			return filler
		}
	}


	/**
	Convenience function that returns the given `filler` string and increases
	the counter once. This method is intended for the autoclosure filler
	methods.
	*/
	func mockFillerAuto(filler: String) -> String {
		counter.increment()
		return filler
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
		tester.fill(to: 0, filler: mockFillerAuto("once"))
		XCTAssertEqual(tester, ["once"])
		counter.assertCount(1)

		tester.fill(to: 2, filler: mockFillerAuto("twice"))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(2)

		tester.fill(to: 1, filler: mockFillerAuto("none"))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(0)

		tester.fill(to: 2, filler: mockFillerAuto("none"))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(0)
	}


	func testFillerWithBlock() {
		tester.fill(to: 0, filler: mockFiller("once"))
		XCTAssertEqual(tester, ["once"])
		counter.assertCount(1)

		tester.fill(to: 2, filler: mockFiller("twice"))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(2)

		tester.fill(to: 1, filler: mockFiller("none"))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(0)

		tester.fill(to: 2, filler: mockFiller("none"))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(0)
	}


	func testSubscriptFiller() {
		element = tester[1, filler: mockFillerAuto("first")]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "first"])
		counter.assertCount(2)

		tester[1, filler: mockFillerAuto("none")] = "second"
		XCTAssertEqual(tester, ["first", "second"])
		counter.assertCount(0)

		element = tester[2, filler: mockFillerAuto("third")]
		XCTAssertEqual(element, "third")
		XCTAssertEqual(tester, ["first", "second", "third"])
		counter.assertCount(1)

		element = tester[0, filler: mockFillerAuto("none")]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "second", "third"])
		counter.assertCount(0)

		tester[4, filler: mockFillerAuto("fourth")] = "fifth"
		XCTAssertEqual(tester, ["first", "second", "third", "fourth", "fifth"])
		counter.assertCount(1)
	}


	func testSubscriptFillerWithBlock() {
		element = tester[1, filler: mockFiller("first")]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "first"])
		counter.assertCount(2)

		tester[1, filler: mockFiller("none")] = "second"
		XCTAssertEqual(tester, ["first", "second"])
		counter.assertCount(0)

		element = tester[2, filler: mockFiller("third")]
		XCTAssertEqual(element, "third")
		XCTAssertEqual(tester, ["first", "second", "third"])
		counter.assertCount(1)

		element = tester[0, filler: mockFiller("none")]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "second", "third"])
		counter.assertCount(0)

		tester[4, filler: mockFiller("fourth")] = "fifth"
		XCTAssertEqual(tester, ["first", "second", "third", "fourth", "fifth"])
		counter.assertCount(1)
	}


	func testSubscriptIndexPath() {
		let multiDimentional: [[String]] = [["one"], ["two, three"], ["four"]]

		// Find an existing index
		var indexPath = NSIndexPath(index: 0).indexPathByAddingIndex(0)
		if let shouldBeString = multiDimentional[indexPath] {
			let aString = shouldBeString as! String
			XCTAssertEqual(aString, "one")
		} else {
			XCTFail("nil returned for 0,0 index path")
		}

		// Unexisting index
		indexPath = NSIndexPath(index: 9).indexPathByAddingIndex(9)
		if let shouldBeString = multiDimentional[indexPath] {
			XCTFail("something returned for 9,9 index path")
		}
	}

}
