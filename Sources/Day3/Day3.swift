import ArgumentParser
import Foundation
import Shared

public struct Point : Hashable {
    let x: Int
    let y: Int
}

extension Point : CustomStringConvertible {
    init(_ x: Int, _ y: Int) {
        self.init(x: x, y: y)
    }
    
    public var description: String {
        return "{\(x),\(y)}"
    }
    
    static let origin = Point(0, 0)
    
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    static func +=(lhs: inout Point, rhs: Point) {
        lhs = lhs + rhs
    }
    
    static func %(lhs: Point, rhs: Point) -> Point {
        return Point(lhs.x % rhs.x, lhs.y % rhs.y)
    }
}

public enum Geology : Character {
    case open = "."
    case tree = "#"
}

public typealias Map = [Point : Geology]

extension Map {
    func follow(slope: Point = Point(3, 1)) -> Int {
        guard let maxX = keys.map({ $0.x }).max(),
              let maxY = keys.map({ $0.y }).max()
        else {
            fatalError()
        }

        let maxPoint = Point(maxX + 1, maxY + 1)
        var position = Point.origin
        var trees = 0

        while position.y < maxY {
            position += slope
            
            let mapPoint = position % maxPoint
            guard let geology = self[mapPoint] else {
                fatalError("Failed to get geology for point \(mapPoint)")
            }
            
            guard geology == .tree else {
                continue
            }
            
            trees += 1
        }
        
        return trees
    }
}

public struct Day3 : FileInputCommand {
    public static var configuration = CommandConfiguration (
        commandName: "day3",
        abstract: "Day 3: Toboggan Trajectory"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> Map {
        return Self.parse(rawInput)
    }
    
    public func run(_ input: Map) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    public static func parse(_ text: String) -> Map {
        let lines = text
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
        
        var map: [Point : Geology] = [:]
        
        for (y, line) in lines.enumerated() {
            for (x, character) in line.enumerated() {
                guard let geology = Geology(rawValue: character) else {
                    fatalError()
                }
                
                let point = Point(x: x, y: y)
                map[point] = geology
            }
        }
        
        return map
    }
    
    public static func part1(_ map: Map) -> Int {
        return map.follow()
    }
    
    public static func part2(_ map: Map) -> Int {
        let slopes = [
            Point(1, 1),
            Point(3, 1),
            Point(5, 1),
            Point(7, 1),
            Point(1, 2),
        ]
        
        return slopes.map { map.follow(slope: $0) }.reduce(1, *)
    }
}
