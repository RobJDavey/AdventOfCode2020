import ArgumentParser
import Foundation
import Shared

public typealias State = [Point : Cube]

public enum Cube : Character {
    case active = "#"
    case inactive = "."
}

extension Cube {
    func update(neighbours: [Cube]) -> Cube {
        let activeNeighbourCount = neighbours.filter { $0 == .active }.count
        
        switch self {
        case .active where activeNeighbourCount == 2,
             .active where activeNeighbourCount == 3,
             .inactive where activeNeighbourCount == 3:
            return .active
        default:
            return .inactive
        }
    }
}

public struct Point : Hashable {
    let x: Int
    let y: Int
    let z: Int
    let w: Int
}

extension Point : CustomStringConvertible {
    static let origin = Point(0, 0, 0, 0)
    static let offsetRange = -1...1
    
    init(_ x: Int, _ y: Int, _ z: Int, _ w: Int = 0) {
        self.init(x: x, y: y, z: z, w: w)
    }
    
    public var description: String {
        return "{\(x),\(y),\(z),\(w)}"
    }
    
    func neighbours3D(cache: inout [Point : Set<Point>]) -> Set<Point> {
        let offsets = neighbourOffsets3D(cache: &cache)
        var result: Set<Point> = []
        
        for offset in offsets {
            result.insert(Point(x + offset.x, y + offset.y, z + offset.z))
        }
        
        return result
    }
    
    func neighbours4D(cache: inout [Point : Set<Point>]) -> Set<Point> {
        let offsets = neighbourOffsets4D(cache: &cache)
        var result: Set<Point> = []
        
        for offset in offsets {
            result.insert(Point(x + offset.x, y + offset.y, z + offset.z, w + offset.w))
        }
        
        return result
    }
    
    func neighbourOffsets3D(cache: inout [Point : Set<Point>]) -> Set<Point> {
        if let result = cache[self] {
            return result
        }
        
        var result: Set<Point> = []
        
        for z in Self.offsetRange {
            for y in Self.offsetRange {
                for x in Self.offsetRange {
                    guard x != 0 || y != 0 || z != 0 else {
                        continue
                    }
                    
                    result.insert(Point(x, y, z))
                }
            }
        }
        
        cache[self] = result
        return result
    }
    
    func neighbourOffsets4D(cache: inout [Point : Set<Point>]) -> Set<Point> {
        if let result = cache[self] {
            return result
        }
        
        var result: Set<Point> = []
        
        for w in Self.offsetRange {
            for z in Self.offsetRange {
                for y in Self.offsetRange {
                    for x in Self.offsetRange {
                        guard x != 0 || y != 0 || z != 0 || w != 0 else {
                            continue
                        }
                        
                        result.insert(Point(x, y, z, w))
                    }
                }
            }
        }
        
        cache[self] = result
        return result
    }
}

public struct Day17 : FileInputCommand {
    public typealias InputType = State
    public static let defaultCycles = 6
    
    public static var configuration = CommandConfiguration (
        commandName: "day17",
        abstract: "Day 17: Conway Cubes"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    @Argument(help: "The number of cycles to perform")
    public var cycles: Int = defaultCycles
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> InputType {
        return Self.parse(rawInput)
    }
    
    public static func parse(_ text: String) -> InputType {
        let lines = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
        
        var result: [Point : Cube] = [:]
        
        for (y, line) in lines.enumerated() {
            for (x, char) in line.enumerated() {
                guard let cube = Cube(rawValue: char) else { fatalError() }
                result[Point(x, y, 0, 0)] = cube
            }
        }
        
        return result
    }
    
    public func run(_ input: InputType) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input, cycles: cycles)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input, cycles: cycles)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ state: InputType, cycles: Int = defaultCycles) -> Int {
        var state = state
        var cache: [Point : Set<Point>] = [:]
        
        for cycle in 1...cycles {
            let minY = state.keys.map { $0.y }.min() ?? 0
            let maxY = state.keys.map { $0.y }.max() ?? 0
            let minX = state.keys.map { $0.x }.min() ?? 0
            let maxX = state.keys.map { $0.x }.max() ?? 0

            for z in -cycle...cycle {
                for y in (minY - 1)...(maxY + 1) {
                    for x in (minX - 1)...(maxX + 1) {
                        let point = Point(x, y, z)
                        state[point] = state[point, default: .inactive]
                    }
                }
            }
            
            state = Dictionary<Point, Cube>(uniqueKeysWithValues: state.map { (point, cube) in
                let neighbours = point.neighbours3D(cache: &cache)
                assert(neighbours.count == 26)
                let n = neighbours.compactMap { np in state[np, default: .inactive] }
                let c = cube.update(neighbours: n)
                return (key: point, value: c)
            })
        }
        
        return state.values.filter { $0 == .active }.count
    }

    public static func part2(_ state: InputType, cycles: Int = defaultCycles) -> Int {
        var state = state
        var cache: [Point : Set<Point>] = [:]
        
        for cycle in 1...cycles {
            let minY = state.keys.map { $0.y }.min() ?? 0
            let maxY = state.keys.map { $0.y }.max() ?? 0
            let minX = state.keys.map { $0.x }.min() ?? 0
            let maxX = state.keys.map { $0.x }.max() ?? 0
            
            for w in -cycle...cycle {
                for z in -cycle...cycle {
                    for y in (minY - 1)...(maxY + 1) {
                        for x in (minX - 1)...(maxX + 1) {
                            let point = Point(x, y, z, w)
                            state[point] = state[point, default: .inactive]
                        }
                    }
                }
            }
            
            state = Dictionary<Point, Cube>(uniqueKeysWithValues: state.map { (point, cube) in
                let neighbours = point.neighbours4D(cache: &cache)
                assert(neighbours.count == 80)
                let n = neighbours.compactMap { np in state[np, default: .inactive] }
                let c = cube.update(neighbours: n)
                return (key: point, value: c)
            })
        }
        
        return state.values.filter { $0 == .active }.count
    }
}
