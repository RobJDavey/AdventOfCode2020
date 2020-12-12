import XCTest

@testable import Day12

final class Day12Tests: XCTestCase {
    let testInput = """
    F10
    N3
    F7
    R90
    F11
    """
    
    func testPart1() {
        let testActions = Day12.parse(testInput)
        let test1 = Day12.part1(testActions)
        XCTAssertEqual(test1, 25)
    }
    
    func testPart2() {
        let testActions = Day12.parse(testInput)
        let test2 = Day12.part2(testActions)
        XCTAssertEqual(test2, 286)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
