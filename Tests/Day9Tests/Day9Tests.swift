import XCTest

@testable import Day9

final class Day9Tests: XCTestCase {
    let testInput = [
        35,
        20,
        15,
        25,
        47,
        40,
        62,
        55,
        65,
        95,
        102,
        117,
        150,
        182,
        127,
        219,
        299,
        277,
        309,
        576,
    ]
    
    func testPart1() throws {
        let answer1 = try Day9.part1(numbers: testInput, preamble: 5)
        XCTAssertEqual(answer1, 127)
    }
    
    func testPart2() throws {
        let answer2 = try Day9.part2(numbers: testInput, preamble: 5, target: 127)
        XCTAssertEqual(answer2, 62)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
