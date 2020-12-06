import XCTest

@testable import Day6

final class Day6Tests: XCTestCase {
    let testData = """
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """
    
    func testParse() {
        let groups = Day6.parse(testData)
        XCTAssertEqual(groups.count, 5)
        XCTAssertEqual(groups[0], "abc")
        
        XCTAssertEqual(groups[1], """
            a
            b
            c
            """)
        
        XCTAssertEqual(groups[2], """
            ab
            ac
            """)
        
        XCTAssertEqual(groups[3], """
            a
            a
            a
            a
            """)
        
        XCTAssertEqual(groups[4], "b")
    }
    
    func testPart1() {
        let groups = Day6.parse(testData)
        let answer1 = Day6.part1(groups)
        XCTAssertEqual(answer1, 11)
    }
    
    func testPart2() {
        let groups = Day6.parse(testData)
        let answer2 = Day6.part2(groups)
        XCTAssertEqual(answer2, 6)
    }

    static var allTests = [
        ("testParse", testParse),
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
