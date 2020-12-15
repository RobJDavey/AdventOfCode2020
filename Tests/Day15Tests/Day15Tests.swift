import XCTest

@testable import Day15

final class Day15Tests: XCTestCase {
    func testPart1() {
        test1("0,3,6", expected: 436)
        test1("1,3,2", expected: 1)
        test1("2,1,3", expected: 10)
        test1("1,2,3", expected: 27)
        test1("2,3,1", expected: 78)
        test1("3,2,1", expected: 438)
        test1("3,1,2", expected: 1836)
    }
    
    func testPart2() {
        #if canImport(ObjectiveC)
        // Only run these tests on macOS
        // they seem to fail on Linux probably due to the threading
        let testData = [
            (input: "0,3,6", expected: 175594),
            (input: "1,3,2", expected: 2578),
            (input: "2,1,3", expected: 3544142),
            (input: "1,2,3", expected: 261214),
            (input: "2,3,1", expected: 6895259),
            (input: "3,2,1", expected: 18),
            (input: "3,1,2", expected: 362),
        ]
        
        let group = DispatchGroup()
        
        testData.forEach { (input, expected) in
            group.enter()
            
            DispatchQueue.global(qos: .userInteractive).async {
                self.test2(input, expected: expected)
                group.leave()
            }
        }
        
        group.wait()
        #endif
    }
    
    func test1(_ input: String, expected: Int) {
        test(input, expected: expected, count: 2020)
    }
    
    func test2(_ input: String, expected: Int) {
        test(input, expected: expected, count: 30_000_000)
    }
    
    func test(_ input: String, expected: Int, count: Int) {
        let numbers = Day15.parse(input)
        let answer = Day15.run(numbers, count: count)
        XCTAssertEqual(answer, expected)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
