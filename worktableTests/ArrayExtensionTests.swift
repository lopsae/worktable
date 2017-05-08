import XCTest
import Foundation


class ArrayExtension: XCTestCase {

	/**
	Returns a closure that returns the given `string` and increases the 
	`counter` once.
	*/
	func wrapDelivery(_ string: String, increment counter: Counter) -> (Int) -> String {
		return counter.wrapIncrement() {
			(_: Int) in
			return string
		}
	}


	func testSetFirst() {
		var tester: [String] = []

		tester.setFirst("one")
		XCTAssertEqual(tester.count, 1)
		XCTAssertEqual(tester.first, "one")
		XCTAssertEqual(tester.last, "one")

		tester = ["nil", "two", "three"]
		tester.setFirst("one")
		XCTAssertEqual(tester.count, 3)
		XCTAssertEqual(tester.first, "one")
		XCTAssertEqual(tester[1], "two")
		XCTAssertEqual(tester.last, "three")
	}


	func testSetLast() {
		var tester: [String] = []

		tester.setLast("one")
		XCTAssertEqual(tester.count, 1)
		XCTAssertEqual(tester.first, "one")
		XCTAssertEqual(tester.last, "one")

		tester = ["one", "two", "nil"]
		tester.setLast("three")
		XCTAssertEqual(tester.count, 3)
		XCTAssertEqual(tester.last, "three")
		XCTAssertEqual(tester[1], "two")
		XCTAssertEqual(tester.first, "one")
	}


	func testFiller() {
		var tester: [String] = []
		let counter = Counter()

		tester.fill(to: 0, filler: counter.deliver("none"))
		XCTAssertEqual(tester, [])
		counter.assertCount(0)

		tester.fill(to: 1, filler: counter.deliver("once"))
		XCTAssertEqual(tester, ["once"])
		counter.assertCount(1)

		tester.fill(to: 3, filler: counter.deliver("twice"))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(2)

		tester.fill(to: 0, filler: counter.deliver("none"))
		tester.fill(to: 1, filler: counter.deliver("none"))
		tester.fill(to: 3, filler: counter.deliver("none"))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(0)
	}


	func testFillerWithClosure() {
		var tester: [String] = []
		let counter = Counter()

		tester.fill(to: 0, filler: wrapDelivery("none", increment: counter))
		XCTAssertEqual(tester, [])
		counter.assertCount(0)

		tester.fill(to: 1, filler: wrapDelivery("once", increment: counter))
		XCTAssertEqual(tester, ["once"])
		counter.assertCount(1)

		tester.fill(to: 3, filler: wrapDelivery("twice", increment: counter))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(2)

		tester.fill(to: 0, filler: wrapDelivery("none", increment: counter))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(0)

		tester.fill(to: 3, filler: wrapDelivery("none", increment: counter))
		XCTAssertEqual(tester, ["once", "twice", "twice"])
		counter.assertCount(0)
	}


	func testSubscriptFiller() {
		var tester: [String] = []
		let counter = Counter()
		var element: String

		func deliver(_ string: String) -> String {
			counter.increment()
			return string
		}

		element = tester[1, filler: deliver("first")]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "first"])
		counter.assertCount(2)

		tester[1, filler: deliver("none")] = "second"
		XCTAssertEqual(tester, ["first", "second"])
		counter.assertCount(0)

		element = tester[2, filler: deliver("third")]
		XCTAssertEqual(element, "third")
		XCTAssertEqual(tester, ["first", "second", "third"])
		counter.assertCount(1)

		element = tester[0, filler: deliver("none")]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "second", "third"])
		counter.assertCount(0)

		tester[4, filler: deliver("fourth")] = "fifth"
		XCTAssertEqual(tester, ["first", "second", "third", "fourth", "fifth"])
		counter.assertCount(1)
	}


	func testSubscriptFillerWithClosure() {
		var tester: [String] = []
		let counter = Counter()
		var element: String

		element = tester[1, filler: wrapDelivery("first", increment: counter)]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "first"])
		counter.assertCount(2)

		tester[1, filler: wrapDelivery("none", increment: counter)] = "second"
		XCTAssertEqual(tester, ["first", "second"])
		counter.assertCount(0)

		element = tester[2, filler: wrapDelivery("third", increment: counter)]
		XCTAssertEqual(element, "third")
		XCTAssertEqual(tester, ["first", "second", "third"])
		counter.assertCount(1)

		element = tester[0, filler: wrapDelivery("none", increment: counter)]
		XCTAssertEqual(element, "first")
		XCTAssertEqual(tester, ["first", "second", "third"])
		counter.assertCount(0)

		tester[4, filler: wrapDelivery("fourth", increment: counter)] = "fifth"
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
