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
	func mockFiller(_ filler: String) -> (Int) -> String {
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
	func mockFillerAuto(_ filler: String) -> String {
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


	func testArrayFollow() {
		let multiDimentional: [[String]] = [
			["zero,zero"],
			["one,zero", "one,one"],
			["two,zero"]
		]

		XCTAssertNil(multiDimentional.follow(path: [9, 9]),
			"invalid array path should return nil"
		)

		XCTAssertNil(multiDimentional.follow(path: IndexPath(indexes: [9, 9])),
			"invalid IndexPath path should return nil"
		)

		var arrayAsAny = multiDimentional.follow(path: [2])
		XCTAssertNotNil(arrayAsAny,
			"partial array path should return array"
		)
		XCTAssertEqual(arrayAsAny as! [String], ["two,zero"],
			"partial array path should return specific array"
		)

		arrayAsAny = multiDimentional.follow(path: IndexPath(indexes: [2]))
		XCTAssertNotNil(arrayAsAny,
			"partial IndexPath path should return array"
		)
		XCTAssertEqual(arrayAsAny as! [String], ["two,zero"],
			"partial IndexPath path should return specific array"
		)

		// Find an existing index
		var stringAsAny = multiDimentional.follow(path: [0, 0])
		XCTAssertNotNil(stringAsAny,
			"full array path should return string"
		)
		XCTAssertEqual(stringAsAny as? String, "zero,zero",
			"full array path should return specific string"
		)

		stringAsAny = multiDimentional.follow(path: IndexPath(indexes: [0, 0]))
		XCTAssertNotNil(stringAsAny,
			"full IndexPath path should return string"
		)
		XCTAssertEqual(stringAsAny as? String, "zero,zero",
			"full IndexPath path should return specific string"
		)

		XCTAssertNil(multiDimentional.follow(path: [1, 1, 1]),
			"invalid array path should return nil"
		)

		XCTAssertNil(multiDimentional.follow(path: IndexPath(indexes: [1, 1, 1])),
			"invalid IndexPath path should return nil"
		)

		// TODO: add out of bounds?
	}

}
