import XCTest

@testable import Day7

final class Day7Tests: XCTestCase {
    let testInput1 = """
    light red bags contain 1 bright white bag, 2 muted yellow bags.
    dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    bright white bags contain 1 shiny gold bag.
    muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
    shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
    dark olive bags contain 3 faded blue bags, 4 dotted black bags.
    vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    faded blue bags contain no other bags.
    dotted black bags contain no other bags.
    """

    let testInput2 = """
    shiny gold bags contain 2 dark red bags.
    dark red bags contain 2 dark orange bags.
    dark orange bags contain 2 dark yellow bags.
    dark yellow bags contain 2 dark green bags.
    dark green bags contain 2 dark blue bags.
    dark blue bags contain 2 dark violet bags.
    dark violet bags contain no other bags.
    """
    
    func testPart1() throws {
        let bags = try Day7.parse(testInput1)
        XCTAssert(bags.count == 9)
        
        let target: Bag! = bags.first(where: { $0.color == "shiny gold" })
        XCTAssertNotNil(target)
        
        let result1 = Day7.part1(bags, target: target)
        XCTAssertEqual(result1, 4)
    }
    
    func testPart2Example1() throws {
        let bags = try Day7.parse(testInput1)
        XCTAssert(bags.count == 9)
        
        let target: Bag! = bags.first(where: { $0.color == "shiny gold" })
        XCTAssertNotNil(target)
        
        let result1 = Day7.part2(bags, target: target)
        XCTAssertEqual(result1, 32)
    }
    
    func testPart2Example2() throws {
        let bags = try Day7.parse(testInput2)
        XCTAssert(bags.count == 7)
        
        let target: Bag! = bags.first(where: { $0.color == "shiny gold" })
        XCTAssertNotNil(target)
        
        let result1 = Day7.part2(bags, target: target)
        XCTAssertEqual(result1, 126)
    }

    static var allTests = [
        ("testPart1", testPart1),
        ("testPart2Example1", testPart2Example1),
        ("testPart2Example2", testPart2Example2),
    ]
}
