import XCTest


class ArrayExtension: XCTestCase {

	var tester: [String] = [];

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


	func testSetFirst() {
		// With emtpy array
		tester = []
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
		tester = []
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

}
