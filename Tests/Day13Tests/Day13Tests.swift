import XCTest

@testable import Day13

final class Day13Tests: XCTestCase {
    let testInput = """
    939
    7,13,x,x,59,x,31,19
    """
    
    func testPart1() {
        let testBusInfo = Day13.parse(testInput)
        let answer = Day13.part1(testBusInfo)
        XCTAssertEqual(answer, 295)
    }
    
    func testPart2() {
        runPart2Test(testInput, expected: 1068781)
        runPart2Test("17,x,13,19", expected: 3417)
        runPart2Test("67,7,59,61", expected: 754018)
        runPart2Test("67,x,7,59,61", expected: 779210)
        runPart2Test("67,7,x,59,61", expected: 1261476)
        runPart2Test("1789,37,47,1889", expected: 1202161486)
    }
    
    func runPart2Test(_ input: String, expected: Int) {
        let line = input.components(separatedBy: .newlines).last!
        let busInfo = Day13.parse("0\n\(line)")
        let answer = Day13.part2(busInfo)
        XCTAssertEqual(answer, expected)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
