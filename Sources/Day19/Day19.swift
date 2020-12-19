import ArgumentParser
import Foundation
import Shared

public typealias Rules = [Int : Rule]

public enum Rule {
    case literal(Character)
    case group([Int])
    case choice([Rule])
}

extension Rule {
    func evaluate(_ string: String, rules: Rules) -> Bool {
        let indexes = [string.startIndex]
        let result = evaluate(string, rules: rules, indexes: indexes)
        return result.contains { $0 == string.endIndex }
    }
    
    private func evaluate(_ string: String, rules: Rules, indexes: [String.Index]) -> [String.Index] {
        var next: [String.Index] = []
        
        switch self {
        case let .literal(literal):
            for index in indexes {
                guard index < string.endIndex else {
                    continue
                }
                
                let character = string[index]
                
                guard character == literal else {
                    continue
                }
                
                next.append(string.index(after: index))
            }
        case let .group(group):
            let items = group.compactMap { rules[$0] }
            
            for index in indexes {
                var i = [index]
                
                for item in items {
                    i = item.evaluate(string, rules: rules, indexes: i)
                }
                
                next += i
            }
        case let .choice(choices):
            for group in choices {
                let result = group.evaluate(string, rules: rules, indexes: indexes)
                next += result
            }
        }
        
        return next
    }
}

public struct Day19 : FileInputCommand {
    public typealias InputType = (rules: Rules, strings: [String])
    
    public static var configuration = CommandConfiguration (
        commandName: "day19",
        abstract: "Day 19: Monster Messages"
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
        let allLines = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
        
        let ruleLines = allLines[0].components(separatedBy: .newlines)
        let strings = allLines[1].components(separatedBy: .newlines)
        
        var rules: [Int : Rule] = [:]
        
        for line in ruleLines {
            let initialComponents = line.components(separatedBy: ": ")
            assert(initialComponents.count == 2)
            
            guard let id = Int(initialComponents[0]) else {
                fatalError()
            }
            
            let remainder = initialComponents[1]
            if let range = remainder.range(of: #""(\w)""#, options: .regularExpression) {
                let value = remainder.index(after: range.lowerBound)
                rules[id] = .literal(remainder[value])
                continue
            }
            
            let split = remainder.components(separatedBy: " | ")
            var groups: [Rule] = []
            
            for part in split {
                let numbers = part
                    .components(separatedBy: " ")
                    .compactMap(Int.init)
                
                groups.append(.group(numbers))
            }
            
            switch groups.count {
            case 1:
                rules[id] = groups[0]
            default:
                rules[id] = .choice(groups)
            }
        }
        
        return (rules, strings)
    }
    
    public func run(_ input: InputType) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    public static func run(rules: Rules, strings: [String]) -> Int {
        let rule0 = rules[0]!
        
        var count = 0
        
        for string in strings {
            if rule0.evaluate(string, rules: rules) {
                count += 1
            }
        }
        
        return count
    }
    
    public static func part1(_ input: InputType) -> Int {
        let (rules, strings) = input
        return run(rules: rules, strings: strings)
    }

    public static func part2(_ input: InputType) -> Int {
        var (rules, strings) = input
        rules[8] = .choice([.group([42]), .group([42, 8])])
        rules[11] = .choice([.group([42, 31]), .group([42, 11, 31])])
        return run(rules: rules, strings: strings)
    }
}
