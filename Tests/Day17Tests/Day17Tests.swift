import XCTest

@testable import Day17

final class Day17Tests: XCTestCase {
    let testInput = """
    .#.
    ..#
    ###
    """
    
    func testPart1() {
        let state = Day17.parse(testInput)
        let answer = Day17.part1(state)
        XCTAssertEqual(answer, 112)
    }
    
    func testPart2() {
        let state = Day17.parse(testInput)
        let answer = Day17.part2(state)
        XCTAssertEqual(answer, 848)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
