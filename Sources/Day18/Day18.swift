import ArgumentParser
import Foundation
import Shared

let ops: [Character : (Int, Int) -> Int] = [
    "+": (+),
    "*": (*),
]

func calculateGroup(_ line: String, index: inout String.Index) -> Int {
    var total = 0
    var op: (Int, Int) -> Int = { $0 + $1 }
    var digits: [Character] = []
    
    while index < line.endIndex {
        let character = line[index]
        index = line.index(after: index)
        
        switch character {
        case "(":
            let group = calculateGroup(line, index: &index)
            total = op(total, group)
        case ")":
            if let number = Int(String(digits)) {
                total = op(total, number)
            }
            
            return total
        case " ":
            if let number = Int(String(digits)) {
                digits = []
                total = op(total, number)
            }
            continue
        case "+", "*":
            op = ops[character]!
        default:
            digits.append(character)
        }
    }
    
    if let number = Int(String(digits)) {
        total = op(total, number)
    }
    
    return total
}

func calculatePart1(_ line: String) -> Int {
    var index = line.startIndex
    return calculateGroup(line, index: &index)
}

func replace(_ line: inout String, symbol: Character, op: (Int, Int) -> Int) -> Bool {
    let ungroupedPattern = #"\d+ "# + "\\\(symbol)" + #" \d+"#
    let groupedPattern = #"\("# + ungroupedPattern + #"\)"#
    let ungroupedRange = line.range(of: ungroupedPattern, options: .regularExpression)
    let groupedRange = line.range(of: groupedPattern, options: .regularExpression)
    
    guard let range = groupedRange ?? ungroupedRange else {
        return false
    }
    
    let text = line[range]
    let components = text
        .replacingOccurrences(of: "(", with: "")
        .replacingOccurrences(of: ")", with: "")
        .components(separatedBy: .whitespaces)
    assert(components.count == 3)
    
    guard let lhs = Int(components[0]), let rhs = Int(components[2]) else {
        fatalError()
    }
    
    let result = op(lhs, rhs)
    line.replaceSubrange(range, with: "\(result)")
    return true
}

func replaceGroup(_ line: inout String) -> Bool {
    guard let range = line.range(of: #"\(\d+\)"#, options: .regularExpression) else {
        return false
    }
    
    let text = line[range].dropFirst().dropLast()
    line.replaceSubrange(range, with: "\(text)")
    return true
}

func findGroup(_ line: inout String) -> Bool {
    guard let range = line.range(of: #"\([^()]+\)"#, options: .regularExpression) else {
        return false
    }
    
    let text = String(line[range].dropFirst().dropLast())
    let result = calculatePart2(text)
    line.replaceSubrange(range, with: "\(result)")
    return true
}

func calculatePart2(_ line: String) -> Int {
    var line = line
    
    while true {
        if !findGroup(&line) {
            if !replace(&line, symbol: "+", op: +) {
                if !replace(&line, symbol: "*", op: *) {
                        break
                }
            }
        }
    }
    
    guard let result = Int(line) else {
        fatalError()
    }
    
    return result
}

public struct Day18 : FileInputCommand {
    public typealias InputType = [String]
    
    public static var configuration = CommandConfiguration (
        commandName: "day18",
        abstract: "Day 18: Operation Order"
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
    }
    
    public func run(_ input: InputType) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ state: InputType) -> Int {
        return state
            .map(calculatePart1)
            .reduce(0, +)
    }

    public static func part2(_ state: InputType) -> Int {
        return state
            .map(calculatePart2)
            .reduce(0, +)
    }
}
