import XCTest

@testable import Day2

final class Day2Tests: XCTestCase {
    let testData = """
        1-3 a: abcde
        1-3 b: cdefg
        2-9 c: ccccccccc
        """
    
    func testPolicy() {
        let policies = testData.components(separatedBy: .newlines).compactMap(PasswordPolicy.init)
        XCTAssertEqual(policies.count, 3)
        
        let a: PasswordPolicy = policies[0]
        XCTAssertEqual(a.lowerBound, 1)
        XCTAssertEqual(a.upperBound, 3)
        XCTAssertEqual(a.character, "a")
        XCTAssertEqual(a.password, "abcde")
        
        let b: PasswordPolicy = policies[1]
        XCTAssertEqual(b.lowerBound, 1)
        XCTAssertEqual(b.upperBound, 3)
        XCTAssertEqual(b.character, "b")
        XCTAssertEqual(b.password, "cdefg")
        
        let c: PasswordPolicy = policies[2]
        XCTAssertEqual(c.lowerBound, 2)
        XCTAssertEqual(c.upperBound, 9)
        XCTAssertEqual(c.character, "c")
        XCTAssertEqual(c.password, "ccccccccc")
    }
    
    func testPart1() {
        let validator = Part1()
        let policies = testData.components(separatedBy: .newlines).compactMap(PasswordPolicy.init)
        testValidator(validator, policies: policies, expectedResults: [true, false, true], expectedCount: 2)
    }
    
    func testPart2() {
        let validator = Part2()
        let policies = testData.components(separatedBy: .newlines).compactMap(PasswordPolicy.init)
        testValidator(validator, policies: policies, expectedResults: [true, false, false], expectedCount: 1)
    }
    
    func testValidator(_ validator: PasswordValidator, policies: [PasswordPolicy], expectedResults: [Bool], expectedCount: Int) {
        precondition(policies.count == expectedResults.count)
        let results = policies.map { validator.isValid($0) }
        
        let count = results.filter { $0 }.count
        XCTAssertEqual(count, expectedCount)
        
        for (expected, actual) in zip(expectedResults, results) {
            XCTAssertEqual(expected, actual)
        }
    }

    static var allTests = [
        ("testPolicy", testPolicy),
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
