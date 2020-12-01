import Algorithms
import ArgumentParser
import Foundation
import Shared

public struct Day1 : FileInputCommand {
    public static let defaultTarget = 2020
    
    public static var configuration = CommandConfiguration (
        commandName: "day1",
        abstract: "Day 1: Report Repair"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    @Argument(help: "The target amount")
    public var target: Int = defaultTarget
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> [Int] {
        return rawInput.components(separatedBy: .whitespacesAndNewlines).compactMap { Int($0) }
    }
    
    public func run(_ input: [Int]) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = try Self.part1(input, target: target)
        print("Part 1: \(answer1)")

        let answer2 = try Self.part2(input, target: target)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ expenseReport: [Int], target: Int = defaultTarget) throws -> Int {
        try run(expenseReport, target: target, combinations: 2)
    }

    public static func part2(_ expenseReport: [Int], target: Int = defaultTarget) throws -> Int {
        try run(expenseReport, target: target, combinations: 3)
    }
    
    static func run(_ expenseReport: [Int], target: Int, combinations: Int) throws -> Int {
        for combination in expenseReport.combinations(ofCount: combinations) {
            guard combination.reduce(0, +) == target else {
                continue
            }
            
            return combination.reduce(1, *)
        }
        
        throw Day1Error.noMatchingCombination
    }
    
    enum Day1Error : String, Error {
        case noMatchingCombination = "Unable to find a matching combination of numbers"
    }
}
