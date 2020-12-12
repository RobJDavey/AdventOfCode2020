import ArgumentParser
import Foundation
import Shared

public enum Action {
    case north(Int)
    case south(Int)
    case east(Int)
    case west(Int)
    case left(Int)
    case right(Int)
    case forward(Int)
}

extension Action {
    init?(_ text: String) {
        let index = text.index(after: text.startIndex)
        let actionText = text[text.startIndex]
        let valueText = text[index...]
        guard let value = Int(valueText) else { return nil }
        
        switch actionText {
        case "N":
            self = .north(value)
        case "S":
            self = .south(value)
        case "E":
            self = .east(value)
        case "W":
            self = .west(value)
        case "L":
            self = .left(value)
        case "R":
            self = .right(value)
        case "F":
            self = .forward(value)
        default:
            return nil
        }
    }
}

enum Direction : Int {
    case north = 0
    case east = 90
    case south = 180
    case west = 270
}

extension Direction : CustomStringConvertible {
    var description: String {
        switch self {
        case .north:
            return "north"
        case .east:
            return "east"
        case .south:
            return "south"
        case .west:
            return "west"
        }
    }
    
    func rotateLeft(by degrees: Int) -> Direction {
        return rotateRight(by: 360 - degrees)
    }
    
    func rotateRight(by degrees: Int) -> Direction {
        let newDegrees = rawValue + degrees
        guard let newDirection = Direction(rawValue: newDegrees % 360) else { fatalError() }
        return newDirection
    }
}

struct Point {
    let x: Int
    let y: Int
}

extension Point : CustomStringConvertible {
    static let origin = Point(x: 0, y: 0)
    
    var description: String {
        var result = ""
        
        switch x {
        case 0...:
            result += "east \(x)"
        default:
            result += "west \(abs(x))"
        }
        
        result += ", "
        
        switch y {
        case 0...:
            result += "north \(y)"
        default:
            result += "south \(abs(y))"
        }
        
        return result
    }
    
    func rotate(by degrees: Int) -> Point {
        switch degrees {
        case 90:
            return Point(x: y, y: -x)
        case 180:
            return Point(x: -x, y: -y)
        case 270:
            return Point(x: -y, y: x)
        default:
            return self
        }
    }
}

protocol Actionable {
    func perform(action: Action) -> Self
}

struct Ship1 {
    let position: Point
    let direction: Direction
}

extension Ship1 : CustomStringConvertible {
    var description: String {
        return "\(position), facing \(direction)"
    }
}

struct Ship2 {
    let position: Point
    let waypoint: Point
}

extension Ship2 : CustomStringConvertible {
    var description: String {
        return "ship at \(position), waypoint at \(waypoint)"
    }
}

extension Ship1 : Actionable {
    func move(_ direction: Direction, by value: Int) -> Ship1 {
        switch direction {
        case .north:
            return Ship1(position: Point(x: position.x, y: position.y + value), direction: self.direction)
        case .east:
            return Ship1(position: Point(x: position.x + value, y: position.y), direction: self.direction)
        case .south:
            return Ship1(position: Point(x: position.x, y: position.y - value), direction: self.direction)
        case .west:
            return Ship1(position: Point(x: position.x - value, y: position.y), direction: self.direction)
        }
    }
    
    func perform(action: Action) -> Ship1 {
        switch action {
        case let .north(value):
            return move(.north, by: value)
        case let .east(value):
            return move(.east, by: value)
        case let .south(value):
            return move(.south, by: value)
        case let .west(value):
            return move(.west, by: value)
        case let .left(degrees):
            return Ship1(position: position, direction: direction.rotateLeft(by: degrees))
        case let .right(degrees):
            return Ship1(position: position, direction: direction.rotateRight(by: degrees))
        case let .forward(value):
            return move(direction, by: value)
        }
    }
}

extension Ship2 : Actionable {
    func perform(action: Action) -> Ship2 {
        switch action {
        case let .north(value):
            return Ship2(position: position, waypoint: Point(x: waypoint.x, y: waypoint.y + value))
        case let .east(value):
            return Ship2(position: position, waypoint: Point(x: waypoint.x + value, y: waypoint.y))
        case let .south(value):
            return Ship2(position: position, waypoint: Point(x: waypoint.x, y: waypoint.y - value))
        case let .west(value):
            return Ship2(position: position, waypoint: Point(x: waypoint.x - value, y: waypoint.y))
        case let .left(degrees):
            return Ship2(position: position, waypoint: waypoint.rotate(by: 360 - degrees))
        case let .right(degrees):
            return Ship2(position: position, waypoint: waypoint.rotate(by: degrees))
        case let .forward(value):
            return Ship2(position: Point(x: position.x + (value * waypoint.x), y: position.y + (value * waypoint.y)), waypoint: waypoint)
        }
    }
}

public struct Day12 : FileInputCommand {
    public typealias InputType = [Action]
    
    public static var configuration = CommandConfiguration (
        commandName: "day12",
        abstract: "Day 12: Rain Risk"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> InputType {
        return Self.parse(rawInput)
    }
    
    public static func parse(_ text: String) -> InputType {
        return text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap(Action.init)
    }
    
    public func run(_ input: InputType) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ input: InputType) -> Int {
        var ship = Ship1(position: .origin, direction: .east)
        
        for action in input {
            ship = ship.perform(action: action)
        }
        
        return abs(ship.position.x) + abs(ship.position.y)
    }

    public static func part2(_ input: InputType) -> Int {
        var ship = Ship2(position: .origin, waypoint: Point(x: 10, y: 1))
        
        for action in input {
            ship = ship.perform(action: action)
        }
        
        return abs(ship.position.x) + abs(ship.position.y)
    }
}
