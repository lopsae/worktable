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
		tester.assert(count: 1)
		XCTAssertEqual(tester.first, "one")
		XCTAssertEqual(tester.last, "one")

		tester = ["nil", "two", "three"]
		tester.setFirst("one")
		tester.assert(count: 3)
		XCTAssertEqual(tester.first, "one")
		XCTAssertEqual(tester[1], "two")
		XCTAssertEqual(tester.last, "three")
	}


	func testSetLast() {
		var tester: [String] = []

		tester.setLast("one")
		tester.assert(count: 1)
		XCTAssertEqual(tester.first, "one")
		XCTAssertEqual(tester.last, "one")

		tester = ["one", "two", "nil"]
		tester.setLast("three")
		tester.assert(count: 3)
		XCTAssertEqual(tester.last, "three")
		XCTAssertEqual(tester[1], "two")
		XCTAssertEqual(tester.first, "one")
	}


	func testFiller() {
		var tester: [String] = []
		let counter = Counter()

		tester.fill(to: 0, filler: counter.deliver("none"))
		tester.assert(equal: [])
		counter.assert(count: 0).reset()

		tester.fill(to: 1, filler: counter.deliver("once"))
		tester.assert(equal: ["once"])
		counter.assert(count: 1).reset()

		tester.fill(to: 3, filler: counter.deliver("twice"))
		tester.assert(equal: ["once", "twice", "twice"])
		counter.assert(count: 2).reset()

		tester.fill(to: 0, filler: counter.deliver("none"))
		tester.fill(to: 1, filler: counter.deliver("none"))
		tester.fill(to: 3, filler: counter.deliver("none"))
		tester.assert(equal: ["once", "twice", "twice"])
		counter.assert(count: 0).reset()
	}


	func testFillerWithClosure() {
		var tester: [String] = []
		let counter = Counter()

		tester.fill(to: 0, filler: wrapDelivery("none", increment: counter))
		tester.assert(equal: [])
		counter.assert(count: 0).reset()

		tester.fill(to: 1, filler: wrapDelivery("once", increment: counter))
		tester.assert(equal: ["once"])
		counter.assert(count: 1).reset()

		tester.fill(to: 3, filler: wrapDelivery("twice", increment: counter))
		tester.assert(equal: ["once", "twice", "twice"])
		counter.assert(count: 2).reset()

		tester.fill(to: 0, filler: wrapDelivery("none", increment: counter))
		tester.assert(equal: ["once", "twice", "twice"])
		counter.assert(count: 0).reset()

		tester.fill(to: 3, filler: wrapDelivery("none", increment: counter))
		tester.assert(equal: ["once", "twice", "twice"])
		counter.assert(count: 0).reset()
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
		tester.assert(equal: ["first", "first"])
		counter.assert(count: 2).reset()

		tester[1, filler: deliver("none")] = "second"
		tester.assert(equal: ["first", "second"])
		counter.assert(count: 0).reset()

		element = tester[2, filler: deliver("third")]
		XCTAssertEqual(element, "third")
		tester.assert(equal: ["first", "second", "third"])
		counter.assert(count: 1).reset()

		element = tester[0, filler: deliver("none")]
		XCTAssertEqual(element, "first")
		tester.assert(equal: ["first", "second", "third"])
		counter.assert(count: 0).reset()

		tester[4, filler: deliver("fourth")] = "fifth"
		tester.assert(equal: ["first", "second", "third", "fourth", "fifth"])
		counter.assert(count: 1).reset()
	}


	func testSubscriptFillerWithClosure() {
		var tester: [String] = []
		let counter = Counter()
		var element: String

		element = tester[1, filler: wrapDelivery("first", increment: counter)]
		XCTAssertEqual(element, "first")
		tester.assert(equal: ["first", "first"])
		counter.assert(count: 2).reset()

		tester[1, filler: wrapDelivery("none", increment: counter)] = "second"
		tester.assert(equal: ["first", "second"])
		counter.assert(count: 0).reset()

		element = tester[2, filler: wrapDelivery("third", increment: counter)]
		XCTAssertEqual(element, "third")
		tester.assert(equal: ["first", "second", "third"])
		counter.assert(count: 1).reset()

		element = tester[0, filler: wrapDelivery("none", increment: counter)]
		XCTAssertEqual(element, "first")
		tester.assert(equal: ["first", "second", "third"])
		counter.assert(count: 0).reset()

		tester[4, filler: wrapDelivery("fourth", increment: counter)] = "fifth"
		tester.assert(equal: ["first", "second", "third", "fourth", "fifth"])
		counter.assert(count: 1).reset()
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
