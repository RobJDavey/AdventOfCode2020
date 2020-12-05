import XCTest

@testable import Day5

final class Day5Tests: XCTestCase {
    let examples = [
        ("FBFBBFFRLR", 357),
        ("BFFFBBFRRR", 567),
        ("FFFBBBFRRR", 119),
        ("BBFFBBFRLL", 820),
    ]
    
    func testExamples() {
        for (value, expected) in examples {
            let boardingPass = value.compactMap(BoardingPassKey.init)
            let actual = Day5.seatID(for: boardingPass)
            XCTAssertEqual(expected, actual)
        }
    }

    static var allTests = [
        ("testExamples", testExamples),
    ]
}
