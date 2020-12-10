import XCTest

@testable import Day10

final class Day10Tests: XCTestCase {
    let testInput1 = """
    16
    10
    15
    5
    1
    11
    7
    19
    6
    12
    4
    """
    
    let testInput2 = """
    28
    33
    18
    42
    31
    14
    46
    20
    48
    47
    24
    23
    49
    45
    19
    38
    39
    11
    1
    32
    25
    35
    8
    17
    7
    9
    4
    2
    34
    10
    3
    """
    
    func testPart1() {
        let testData1 = Day10.parse(testInput1)
        let testAnswer1 = Day10.part1(testData1)
        XCTAssertEqual(testAnswer1, 35)
        
        let testData2 = Day10.parse(testInput2)
        let testAnswer2 = Day10.part1(testData2)
        XCTAssertEqual(testAnswer2, 220)
    }
    
    func testPart2() {
        let testData1 = Day10.parse(testInput1)
        let testAnswer1 = Day10.part2(testData1)
        XCTAssertEqual(testAnswer1, 8)
        
        let testData2 = Day10.parse(testInput2)
        let testAnswer2 = Day10.part2(testData2)
        XCTAssertEqual(testAnswer2, 19208)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
