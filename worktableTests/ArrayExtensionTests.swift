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

		func assertIndexPathMatch(_ path: [Array<Any>.Index]) -> Any? {
			let arrayReturn = multiDimentional.follow(path: path)
			let indexReturn = multiDimentional.follow(path: IndexPath(indexes: path))

			if arrayReturn == nil {
				XCTAssertNil(arrayReturn)
				XCTAssertNil(indexReturn)
			}

			if arrayReturn is [String] {
				XCTAssertNotNil(indexReturn as? [String])
				XCTAssertEqual(arrayReturn as! [String], indexReturn as! [String])
			}

			if arrayReturn is String {
				XCTAssertNotNil(indexReturn as? String)
				XCTAssertEqual(arrayReturn as! String, indexReturn as! String)
			}

			return arrayReturn
		}

		// Test out of bounds since first index
		// `9` will inmediately yield a nil
		var pathReturn = assertIndexPathMatch([9, 9])
		XCTAssertNil(pathReturn)

		// Test out of bounds on a intenral array
		// `1` will yield an array, `9` is out of bounds
		pathReturn = assertIndexPathMatch([1, 9])
		XCTAssertNil(pathReturn)

		// Test path into a non array
		// `1, 1` yields a string, which is not indexable
		// TODO: or is there access to that index?
		pathReturn = assertIndexPathMatch([1, 1, 1])
		XCTAssertNil(pathReturn)

		// Test partial path
		let arrayAsAny = assertIndexPathMatch([2])
		XCTAssertNotNil(arrayAsAny)
		XCTAssertEqual(arrayAsAny as! [String], ["two,zero"])

		// Test valid path
		let stringAsAny = assertIndexPathMatch([0, 0])
		XCTAssertNotNil(stringAsAny)
		XCTAssertEqual(stringAsAny as? String, "zero,zero")
	}

}
