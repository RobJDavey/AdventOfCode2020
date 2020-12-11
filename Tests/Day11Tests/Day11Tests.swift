import XCTest

@testable import Day11

final class Day11Tests: XCTestCase {
    let testData = """
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
    """
    
    func testPart1() {
        let testSeating = Day11.parse(testData)
        let result = Day11.part1(testSeating)
        XCTAssertEqual(result, 37)
    }
    
    func testPart2() {
        let testSeating = Day11.parse(testData)
        let result = Day11.part2(testSeating)
        XCTAssertEqual(result, 26)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
