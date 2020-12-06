import ArgumentParser
import Foundation
import Shared

public typealias Groups = [String]

public struct Day6 : FileInputCommand {
    public static var configuration = CommandConfiguration (
        commandName: "day6",
        abstract: "Day 6: Custom Customs"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> Groups {
        return Self.parse(rawInput)
    }
    
    public func run(_ input: Groups) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    static let allQuestions = Set("abcdefghijklmnopqrstuvwxyz")
    
    public static func parse(_ text: String) -> Groups {
        return text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
    }
    
    public static func part1(_ groups: Groups) -> Int {
        return groups
            .map { $0.replacingOccurrences(of: "\n", with: "") }
            .map { Set($0) }
            .map { $0.count }
            .reduce(0, +)
    }
    
    public static func part2(_ groups: Groups) -> Int {
        return groups
            .map { $0
                .components(separatedBy: "\n")
                .map { Set($0) }
                .reduce(allQuestions) { $0.intersection($1) }
            }
            .map { $0.count }
            .reduce(0, +)
    }
}
