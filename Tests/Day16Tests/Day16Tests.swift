import XCTest

@testable import Day16

final class Day16Tests: XCTestCase {
    let testInput1 = """
    class: 1-3 or 5-7
    row: 6-11 or 33-44
    seat: 13-40 or 45-50

    your ticket:
    7,1,14

    nearby tickets:
    7,3,47
    40,4,50
    55,2,20
    38,6,12
    """
    
    func testPart1() {
        let testNotes = Day16.parse(testInput1)
        let answer = Day16.part1(testNotes)
        XCTAssertEqual(71, answer)
    }

    static var allTests = [
        ("testPart1", testPart1),
    ]
}
