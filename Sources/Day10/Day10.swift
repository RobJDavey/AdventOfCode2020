import ArgumentParser
import Foundation
import Shared

public struct Day10 : FileInputCommand {
    public static var configuration = CommandConfiguration (
        commandName: "day10",
        abstract: "Day 10: Adapter Array"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> Set<Int> {
        return Self.parse(rawInput)
    }
    
    public static func parse(_ text: String) -> Set<Int> {
        return Set(text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap(Int.init))
    }
    
    public func run(_ values: Set<Int>) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(values)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(values)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ values: Set<Int>) -> Int {
        let max = values.max()!
        var jumps: [Int : Int] = [3 : 1]
        var current = 0

        while current < max {
            for rating in 1...3 where values.contains(current + rating) {
                jumps[rating, default: 0] += 1
                current = current + rating
                break
            }
        }

        let jump1 = jumps[1, default: 0]
        let jump3 = jumps[3, default: 0]
        return jump1 * jump3
    }

    public static func part2(_ values: Set<Int>) -> Int {
        let max = values.max()!
        var cache: [Int : Int] = [max : 1]
        
        func find(_ value: Int) -> Int {
            if let result = cache[value] { return result }
            
            var total = 0
            
            for i in 1...3 where values.contains(value + i) {
                total += find(value + i)
            }
            
            cache[value] = total
            return total
        }
        
        return find(0)
    }
}
