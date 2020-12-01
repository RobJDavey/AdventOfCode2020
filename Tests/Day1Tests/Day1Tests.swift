import XCTest

@testable import Day1

final class Day1Tests: XCTestCase {
    let testData = [
        1721,
        979,
        366,
        299,
        675,
        1456,
    ]
    
    func testPart1() {
        XCTAssertEqual(try Day1.part1(testData), 514579)
    }
    
    func testPart2() {
        XCTAssertEqual(try Day1.part2(testData), 241861950)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
