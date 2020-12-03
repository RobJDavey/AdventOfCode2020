import XCTest

@testable import Day3

final class Day3Tests: XCTestCase {
    let testInput = """
    ..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#
    """
    
    func testMapParse() {
        let map = Day3.parse(testInput)
        
        let a = map[Point(0, 0)]
        XCTAssertNotNil(a)
        XCTAssertEqual(a, .open)
        
        let b = map[Point(10, 10)]
        XCTAssertNotNil(b)
        XCTAssertEqual(b, .tree)
        
        let c = map[Point(11, 11)]
        XCTAssertNil(c)
        
        let d = map[Point(11, 10)]
        XCTAssertNil(d)
        
        let e = map[Point(10, 11)]
        XCTAssertNil(e)
        
        let f = map[Point(5, 5)]
        XCTAssertNotNil(f)
        XCTAssertEqual(f, .tree)
    }
    
    func testPart1() {
        let map = Day3.parse(testInput)
        let result = Day3.part1(map)
        XCTAssertEqual(result, 7)
    }
    
    func testPart2() {
        let map = Day3.parse(testInput)
        let result = Day3.part2(map)
        XCTAssertEqual(result, 336)
    }

    static var allTests = [
        ("testMapParse", testMapParse),
        ("testPart1", testPart1),
        ("testPart2", testPart2),
    ]
}
