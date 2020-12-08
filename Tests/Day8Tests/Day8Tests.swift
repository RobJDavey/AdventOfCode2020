import XCTest

@testable import Day8

final class Day8Tests: XCTestCase {
    let testInstructions = """
    nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6
    """
    
    func testParseAcc() throws {
        let acc = Instruction("acc +10")
        XCTAssertNotNil(acc)
    
        guard case let .acc(value) = acc else {
            XCTFail()
            return
        }
    
        XCTAssertEqual(value, 10)
    }
    
    func testParseJmp() throws {
        let jmp = Instruction("jmp +11")
        XCTAssertNotNil(jmp)
    
        guard case let .jmp(value) = jmp else {
            XCTFail()
            return
        }
    
        XCTAssertEqual(value, 11)
    }
    
    func testParseNop() throws {
        let nop = Instruction("nop +12")
        XCTAssertNotNil(nop)
    
        guard case let .nop(value) = nop else {
            XCTFail()
            return
        }
    
        XCTAssertEqual(value, 12)
    }
    
    func testParse() {
        XCTAssertNotNil(Instruction("acc -10"))
        XCTAssertNotNil(Instruction("jmp -11"))
        XCTAssertNotNil(Instruction("nop -12"))
        XCTAssertNotNil(Instruction("acc +0"))
        XCTAssertNotNil(Instruction("acc -0"))
        XCTAssertNotNil(Instruction("acc 0"))
        
        XCTAssertNil(Instruction("acc"))
        XCTAssertNil(Instruction("acc -10 +10"))
        XCTAssertNil(Instruction("acc acc"))
    }
    
    func testPart1() {
        let instructions = Day8.parse(testInstructions)
        let result = Day8.part1(instructions)
        XCTAssertEqual(result, 5)
    }
    
    func testPart2() throws {
        let instructions = Day8.parse(testInstructions)
        let result = try Day8.part2(instructions)
        XCTAssertEqual(result, 8)
    }

    static var allTests = [
        ("testParseAcc", testParseAcc),
        ("testParseJmp", testParseJmp),
        ("testParseNop", testParseNop),
        ("testParse", testParse),
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
