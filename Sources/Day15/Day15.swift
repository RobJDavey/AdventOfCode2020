import ArgumentParser
import Foundation
import Shared

public struct Day15 : StringInputCommand {
    public typealias InputType = [Int]
    
    public static var configuration = CommandConfiguration (
        commandName: "day15",
        abstract: "Day 15: Rambunctious Recitation"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInput() -> String {
        return "2,20,0,4,1,17"
    }
    
    public func convert(_ rawInput: String) -> InputType {
        return Self.parse(rawInput)
    }
    
    public static func parse(_ text: String) -> InputType {
        return text
            .components(separatedBy: ",")
            .compactMap(Int.init)
    }
    
    public func run(_ input: InputType) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ numbers: InputType) -> Int {
        return run(numbers, count: 2020)
    }

    public static func part2(_ numbers: InputType) -> Int {
        return run(numbers, count: 3_0000_000)
    }
    
    static func run(_ numbers: [Int], count: Int) -> Int {
        var cache = Dictionary<Int, [Int]>(uniqueKeysWithValues: numbers.enumerated().map({ ($0.element, [$0.offset + 1] )}))
        var last = numbers.last!
        
        for n in (numbers.count + 1)...count {
            let next: Int
            
            if let indexes = cache[last], indexes.count > 1 {
                let lastOneIndex = indexes.index(before: indexes.endIndex)
                let lastTwoIndex = indexes.index(before: lastOneIndex)
                let lastOne = indexes[lastOneIndex]
                let lastTwo = indexes[lastTwoIndex]
                next = lastOne - lastTwo
            } else {
                next = 0
            }
            
            cache[next, default: []].append(n)
            last = next
        }
        
        return last
    }
}
