import ArgumentParser
import Foundation
import Shared

public enum Seat : Character {
    case floor = "."
    case empty = "L"
    case occupied = "#"
}

extension Seat {
    func change(_ adjacent: [Seat], threshold: Int) -> Seat {
        switch self {
        case .empty where adjacent.filter({ $0 == .occupied }).isEmpty:
            return .occupied
        case .occupied where adjacent.filter({ $0 == .occupied }).count >= threshold:
            return .empty
        default:
            return self
        }
    }
}

public struct Point : Hashable {
    let x: Int
    let y: Int
}

extension Point {
    init(_ x: Int, _ y: Int) {
        self.init(x: x, y: y)
    }
    
    static let origin = Point(0, 0)
    
    static let adjacentDeltas = [
        Point(-1, -1),
        Point(-1, 0),
        Point(-1, 1),
        Point(0, -1),
        Point(0, 1),
        Point(1, -1),
        Point(1, 0),
        Point(1, 1),
    ]
    
    var adjacent: [Point] {
        Self.adjacentDeltas.map { Point(x + $0.x, y + $0.y) }
    }
    
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(lhs.x + rhs.x, lhs.y + rhs.y)
    }
    
    static func +=( lhs: inout Point, rhs: Point) {
        lhs = lhs + rhs
    }
}

public typealias Seating = [Point : Seat]

extension Seating {
    func seatsVisibile(from source: Point, maxX: Int, maxY: Int) -> [Seat] {
        func isValid(_ point: Point) -> Bool {
            return point.x >= 0 && point.y >= 0
                && point.x <= maxX && point.y <= maxY
        }
        
        var result: [Seat] = []
        let deltas = Point.adjacentDeltas
        
        for delta in deltas {
            var point = source
            var valid: Bool
            var seat: Seat
            
            repeat {
                point += delta
                valid = isValid(point)
                seat = self[point, default: .floor]
            } while valid && seat == .floor
            
            if valid {
                result.append(seat)
            }
        }
        
        return result
    }
}

public struct Day11 : FileInputCommand {
    public static var configuration = CommandConfiguration (
        commandName: "day11",
        abstract: "Day 11: Seating System"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> Seating {
        return Self.parse(rawInput)
    }
    
    public static func parse(_ text: String) -> Seating {
        let lines = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
        
        var result: [Point : Seat] = [:]
        
        for (y, line) in lines.enumerated() {
            for (x, character) in line.enumerated() {
                let point = Point(x: x, y: y)
                
                guard let seat = Seat(rawValue: character) else {
                    fatalError()
                }
                
                result[point] = seat
            }
        }
        
        return result
    }
    
    public func run(_ values: Seating) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(values)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(values)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ seats: Seating) -> Int {
        let xMax = seats.map { $0.key.x }.max()!
        let yMax = seats.map { $0.key.y }.max()!
        var last = seats
        
        while true {
            var next = seats
            
            for y in 0...yMax {
                for x in 0...xMax {
                    let point = Point(x, y)
                    let seat = last[point, default: .floor]
                    let adjacent = point.adjacent.map { last[$0, default: .floor] }
                    next[point] = seat.change(adjacent, threshold: 4)
                }
            }
            
            guard next != last else {
                break
            }
            
            last = next
        }
        
        let result = last.values.filter { $0 == .occupied }.count
        return result
    }

    public static func part2(_ seats: Seating) -> Int {
        let xMax = seats.map { $0.key.x }.max()!
        let yMax = seats.map { $0.key.y }.max()!
        var last = seats
        
        while true {
            var next = seats
            
            for y in 0...yMax {
                for x in 0...xMax {
                    let point = Point(x, y)
                    let seat = last[point, default: .floor]
                    let adjacent = last.seatsVisibile(from: point, maxX: xMax, maxY: yMax)
                    next[point] = seat.change(adjacent, threshold: 5)
                }
            }
            
            guard next != last else {
                break
            }
            
            last = next
        }
        
        let result = last.values.filter { $0 == .occupied }.count
        return result
    }
}
