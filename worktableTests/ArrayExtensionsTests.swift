import XCTest
import Foundation


class ArrayExtension: XCTestCase {

	/**
	Returns a closure that returns the given `string` and increases `counter`
	once.
	*/
	func wrapDelivery(_ string: String, increment counter: Counter) -> (Int) -> String {
		return counter.wrapIncrement() {
			(_: Int) in
			return string
		}
	}


	func testSetFirst() {
		var tester: [String] = []
		tester.first.assert(equals: nil)

		tester.setFirst("one")
		tester.assert(count: 1)
		tester.first.assert(equals: "one")
		tester.last.assert(equals: "one")

		tester = ["nil", "two", "three"]
		tester.setFirst("one")
		tester.assert(count: 3)
		tester.first.assert(equals: "one")
		tester[1].assert(equals: "two")
		tester.last.assert(equals: "three")
	}


	func testSetLast() {
		var tester: [String] = []
		tester.last.assert(equals: nil)

		tester.setLast("one")
		tester.assert(count: 1)
		tester.first.assert(equals: "one")
		tester.last.assert(equals: "one")

		tester = ["one", "two", "nil"]
		tester.setLast("three")
		tester.assert(count: 3)
		tester.last.assert(equals: "three")
		tester[1].assert(equals: "two")
		tester.first.assert(equals: "one")
	}


	func testFiller() {
		var tester: [String] = []
		let counter = Counter()

		tester.fill(to: 0, filler: counter.deliver("none"))
		tester.assert(equals: [])
		counter.assert(count: 0).reset()

		tester.fill(to: 1, filler: counter.deliver("once"))
		tester.assert(equals: ["once"])
		counter.assert(count: 1).reset()

		tester.fill(to: 3, filler: counter.deliver("twice"))
		tester.assert(equals: ["once", "twice", "twice"])
		counter.assert(count: 2).reset()

		tester.fill(to: 0, filler: counter.deliver("none"))
		tester.fill(to: 1, filler: counter.deliver("none"))
		tester.fill(to: 3, filler: counter.deliver("none"))
		tester.assert(equals: ["once", "twice", "twice"])
		counter.assert(count: 0).reset()
	}


	func testFillerWithClosure() {
		var tester: [String] = []
		let counter = Counter()

		tester.fill(to: 0, filler: wrapDelivery("none", increment: counter))
		tester.assert(equals: [])
		counter.assert(count: 0).reset()

		tester.fill(to: 1, filler: wrapDelivery("once", increment: counter))
		tester.assert(equals: ["once"])
		counter.assert(count: 1).reset()

		tester.fill(to: 3, filler: wrapDelivery("twice", increment: counter))
		tester.assert(equals: ["once", "twice", "twice"])
		counter.assert(count: 2).reset()

		tester.fill(to: 0, filler: wrapDelivery("none", increment: counter))
		tester.assert(equals: ["once", "twice", "twice"])
		counter.assert(count: 0).reset()

		tester.fill(to: 3, filler: wrapDelivery("none", increment: counter))
		tester.assert(equals: ["once", "twice", "twice"])
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
		element.assert(equals: "first")
		tester.assert(equals: ["first", "first"])
		counter.assert(count: 2).reset()

		tester[1, filler: deliver("none")] = "second"
		tester.assert(equals: ["first", "second"])
		counter.assert(count: 0).reset()

		element = tester[2, filler: deliver("third")]
		element.assert(equals: "third")
		tester.assert(equals: ["first", "second", "third"])
		counter.assert(count: 1).reset()

		element = tester[0, filler: deliver("none")]
		element.assert(equals: "first")
		tester.assert(equals: ["first", "second", "third"])
		counter.assert(count: 0).reset()

		tester[4, filler: deliver("fourth")] = "fifth"
		tester.assert(equals: ["first", "second", "third", "fourth", "fifth"])
		counter.assert(count: 1).reset()
	}


	func testSubscriptFillerWithClosure() {
		var tester: [String] = []
		let counter = Counter()
		var element: String

		element = tester[1, filler: wrapDelivery("first", increment: counter)]
		element.assert(equals: "first")
		tester.assert(equals: ["first", "first"])
		counter.assert(count: 2).reset()

		tester[1, filler: wrapDelivery("none", increment: counter)] = "second"
		tester.assert(equals: ["first", "second"])
		counter.assert(count: 0).reset()

		element = tester[2, filler: wrapDelivery("third", increment: counter)]
		element.assert(equals: "third")
		tester.assert(equals: ["first", "second", "third"])
		counter.assert(count: 1).reset()

		element = tester[0, filler: wrapDelivery("none", increment: counter)]
		element.assert(equals: "first")
		tester.assert(equals: ["first", "second", "third"])
		counter.assert(count: 0).reset()

		tester[4, filler: wrapDelivery("fourth", increment: counter)] = "fifth"
		tester.assert(equals: ["first", "second", "third", "fourth", "fifth"])
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
				arrayReturn.assertNil()
				indexReturn.assertNil()
			}

			// TODO: think about using coalescing methods here
			if arrayReturn is [String] {
				indexReturn.assert(is: [String].self)?
				.assert(equals: indexReturn as! [String])
			}

			if arrayReturn is String {
				indexReturn.assert(is: String.self)?
				.assert(equals: indexReturn as? String)
			}

			return arrayReturn
		}

		// Test out of bounds since first index
		// `9` will immediately yield a nil
		var pathReturn = assertIndexPathMatch([9, 9])
		pathReturn.assertNil()

		// Test out of bounds on a intenral array
		// `1` will yield an array, `9` is out of bounds
		pathReturn = assertIndexPathMatch([1, 9])
		pathReturn.assertNil()

		// Test path into a non array
		// `1, 1` yields a string, which is not indexable
		pathReturn = assertIndexPathMatch([1, 1, 1])
		pathReturn.assertNil()

		// Test partial path
		let arrayAsAny = assertIndexPathMatch([2])
		arrayAsAny.assert(is: [String].self)?
		.assert(equals: ["two,zero"])

		// Test valid path
		let stringAsAny = assertIndexPathMatch([0, 0])
		stringAsAny.assert(is: String.self)?
		.assert(equals: "zero,zero")
	}

}
