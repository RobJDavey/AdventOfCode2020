import Algorithms
import ArgumentParser
import Foundation
import Shared

enum Day9Error : String, Error {
    case noValidAnswer
}

public struct Day9 : FileInputCommand {
    public static let defaultPreamble = 25
    
    public static var configuration = CommandConfiguration (
        commandName: "day9",
        abstract: "Day 9: Encoding Error"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    @Argument(help: "The preamble for the transmission")
    public var preamble: Int = defaultPreamble
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> [Int] {
        return rawInput
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap(Int.init)
    }
    
    public func run(_ instructions: [Int]) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = try Self.part1(numbers: instructions, preamble: self.preamble)
        print("Part 1: \(answer1)")

        let answer2 = try Self.part2(numbers: instructions, preamble: self.preamble, target: answer1)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(numbers: [Int], preamble: Int) throws -> Int {
        let startIndex = numbers.index(numbers.startIndex, offsetBy: preamble)
        
        for index in (startIndex..<numbers.endIndex) {
            let n = numbers[index]
            let origin = numbers.index(index, offsetBy: -preamble)
            let previous = Set(numbers[origin..<index])
            let valid = previous.combinations(ofCount: 2)
                .map { $0[0] + $0[1] }
            .contains(n)
            
            guard valid else {
                return n
            }
        }
        
        throw Day9Error.noValidAnswer
    }

    public static func part2(numbers: [Int], preamble: Int, target: Int) throws -> Int {
        let endIndex = numbers.index(numbers.endIndex, offsetBy: -preamble)
        
        for index in numbers.startIndex...endIndex {
            for offset in 1..<preamble {
                let endIndex = numbers.index(index, offsetBy: offset)
                let possible = numbers[index...endIndex]
                let sum = possible.reduce(0, +)
                
                if sum == target {
                    let min = possible.min()!
                    let max = possible.max()!
                    return min + max
                }
                
                if sum > target {
                    break
                }
            }
        }
        
        throw Day9Error.noValidAnswer
    }
}
