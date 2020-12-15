import XCTest

@testable import Day14

final class Day14Tests: XCTestCase {
    let testProgram1 = """
    mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0
    """
    
    let testProgram2 = """
    mask = 000000000000000000000000000000X1001X
    mem[42] = 100
    mask = 00000000000000000000000000000000X0XX
    mem[26] = 1
    """
    
    func testPart1() {
        let instructions = Day14.parse(testProgram1)
        let answer = Day14.part1(instructions)
        XCTAssertEqual(answer, 165)
    }
    
    func testPart2() {
        let instructions = Day14.parse(testProgram2)
        let answer = Day14.part2(instructions)
        XCTAssertEqual(answer, 208)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
