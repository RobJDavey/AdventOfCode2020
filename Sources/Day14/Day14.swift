import ArgumentParser
import Foundation
import Shared

public enum Instruction {
    case mask(String)
    case mem(Int, Int)
}

extension Instruction {
    init?(_ line: String) {
        if let range = line.range(of: "mask = ") {
            let mask = line[range.upperBound...]
            self = .mask(String(mask))
        } else {
            let replaced = line.replacingOccurrences(of: #"^mem\[(\d+)\] = (\d+)$"#, with: "$1=$2", options: .regularExpression)
            let components = replaced.components(separatedBy: "=")
            guard components.count == 2, let memoryIndex = Int(components[0]), let value = Int(components[1]) else { fatalError() }
            self = .mem(memoryIndex, value)
        }
    }
}

public typealias Instructions = [Instruction]

func mask1(_ mask: String, value: Int) -> Int {
    let base2 = String(value, radix: 2)
    let prefix = String(repeating: "0", count: 36 - base2.count)
    let padded = prefix + base2
    
    let elements: [Character] = zip(mask, padded)
        .map { (m, v) in
            switch m {
            case "0", "1":
                return m
            case "X":
                return v
            default:
                fatalError()
            }
        }
    
    return Int(String(elements), radix: 2)!
}

func mask2(_ mask: String, value: Int) -> [Int] {
    let base2 = String(value, radix: 2)
    let prefix = String(repeating: "0", count: 36 - base2.count)
    let padded = prefix + base2
    
    let elements: [Character] = zip(mask, padded)
        .map { (m, v) in
            switch m {
            case "0":
                return v
            case "1":
                return "1"
            case "X":
                return "X"
            default:
                fatalError()
            }
        }
    
    let result = String(elements)
    let results = unmask(result)
    return results.map { Int($0, radix: 2)! }
}

func unmask(_ text: String) -> [String] {
    guard let index = text.firstIndex(of: "X") else {
        return [text]
    }
    
    let a = text.replacingCharacters(in: index...index, with: "0")
    let b = text.replacingCharacters(in: index...index, with: "1")
    return [a, b].flatMap(unmask)
}

public struct Day14 : FileInputCommand {
    public typealias InputType = Instructions
    
    public static var configuration = CommandConfiguration (
        commandName: "day14",
        abstract: "Day 14: Docking Data"
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
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap(Instruction.init)
    }
    
    public func run(_ input: InputType) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ instructions: InputType) -> Int {
        var memory: [Int : Int] = [:]
        var currentMask = String(repeating: "X", count: 36)
    
        for instruction in instructions {
            switch instruction {
            case let .mask(mask):
                currentMask = mask
            case let .mem(address, value):
                let result = mask1(currentMask, value: value)
                memory[address, default: 0] = result
            }
        }
    
        let result = memory.values
            .reduce(0, +)
    
        return result
    }

    public static func part2(_ instructions: InputType) -> Int {
        var memory: [Int : Int] = [:]
        var currentMask = String(repeating: "X", count: 36)
        
        for instruction in instructions {
            switch instruction {
            case let .mask(mask):
                currentMask = mask
            case let .mem(address, value):
                let addresses = mask2(currentMask, value: address)
                addresses.forEach { memory[$0, default: 0] = value }
            }
        }
        
        let result = memory.values
            .reduce(0, +)
        
        return result
    }
}
