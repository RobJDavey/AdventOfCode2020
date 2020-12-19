import ArgumentParser
import Foundation
import Shared

extension ClosedRange where Bound == Int {
    init?(_ text: String) {
        let components = text.components(separatedBy: "-")
        
        guard components.count == 2,
              let start = Int(components[0]),
              let end = Int(components[1])
        else {
            return nil
        }
        
        self = start...end
    }
}

struct Rule : Equatable {
    let name: String
    let ranges: [ClosedRange<Int>]
    
    var first: ClosedRange<Int>! { ranges.first }
    var last: ClosedRange<Int>! { ranges.last }
}

extension Rule {
    init?(_ text: String) {
        guard let labelEndIndex = text.firstIndex(of: ":") else { return nil }
        let label = String(text[text.startIndex..<labelEndIndex])
        let remainderStartIndex = text.index(labelEndIndex, offsetBy: 2)
        let remainder = text[remainderStartIndex...]
        let ranges = remainder
            .components(separatedBy: " or ")
            .compactMap(ClosedRange.init)
        assert(ranges.count == 2)
        self.init(name: label, ranges: ranges)
    }
}

struct Ticket {
    let values: [Int]
}

extension Ticket {
    init(_ text: String) {
        let values = text
            .components(separatedBy: ",")
            .compactMap(Int.init)
        
        self.init(values: values)
    }
}

typealias Rules = [Rule]
typealias Tickets = [Ticket]

public struct Notes {
    let rules: Rules
    let myTicket: Ticket
    let nearbyTickets: Tickets
    
    var allRanges: Set<ClosedRange<Int>> {
        return Set(rules.flatMap { $0.ranges })
    }
}

extension Notes {
    init(fields: String, myTicket: String, nearby: String) {
        let rules = fields
            .components(separatedBy: .newlines)
            .compactMap(Rule.init)
        
        guard let myTicket = myTicket
                .components(separatedBy: .newlines)
                .dropFirst()
                .map(Ticket.init)
                .first
        else {
            fatalError()
        }
        
        let nearbyTickets = nearby
            .components(separatedBy: .newlines)
            .dropFirst()
            .map(Ticket.init)
        
        self.init(rules: rules, myTicket: myTicket, nearbyTickets: nearbyTickets)
    }
}

func getInvalidValues(_ ticket: Ticket, ranges: Set<ClosedRange<Int>>) -> [Int] {
    return ticket.values.filter { value in
        for range in ranges {
            guard !range.contains(value) else {
                return false
            }
        }
        
        return true
    }
}

func isMatch(rule: Rule, values: [Int]) -> Bool {
    for value in values {
        var success = false
        
        for range in rule.ranges {
            guard range.contains(value) else {
                continue
            }
            
            success = true
        }
        
        guard success else {
            return false
        }
    }
    
    return true
}

public struct Day16 : FileInputCommand {
    public typealias InputType = Notes
    
    public static var configuration = CommandConfiguration (
        commandName: "day16",
        abstract: "Day 16: Ticket Translation"
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
        let sections = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
        
        guard sections.count == 3 else { fatalError() }
        
        let fields = sections[0]
        let mine = sections[1]
        let nearby = sections[2]
        
        return Notes(fields: fields, myTicket: mine, nearby: nearby)
    }
    
    public func run(_ input: InputType) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ notes: InputType) -> Int {
        let ranges = Set(notes.rules
            .flatMap { $0.ranges })
        
        let invalid = notes.nearbyTickets
            .flatMap { ticket in getInvalidValues(ticket, ranges: ranges) }
        
        return invalid.reduce(0, +)
    }

    public static func part2(_ notes: InputType) -> Int {
        let allRanges = Set(notes.rules
            .flatMap { $0.ranges })

        let valid = notes.nearbyTickets
            .filter { ticket in
                let invalid = getInvalidValues(ticket, ranges: allRanges)
                return invalid.isEmpty
            }
        
        let indexed = Dictionary(grouping: valid.flatMap({ $0.values.enumerated() }), by: { $0.offset })
            .mapValues { $0.map { $0.element }}
        
        var offsets = Array(notes.myTicket.values.enumerated().map { $0.offset })
        var rules = notes.rules
        var matchedRules: [Int : Rule] = [:]
        
        while !offsets.isEmpty {
            let offset = offsets.removeFirst()
            guard let others = indexed[offset] else { fatalError() }
            var possible: [Int] = []
            
            for (ruleOffset, rule) in rules.enumerated() {
                if isMatch(rule: rule, values: others) {
                    possible.append(ruleOffset)
                }
            }
            
            if possible.count == 1 {
                let ruleOffset = possible[0]
                let rule = rules.remove(at: ruleOffset)
                matchedRules[offset] = rule
            } else {
                offsets.append(offset)
            }
        }
        
        let departures = matchedRules
            .filter { $0.value.name.contains("departure") }
            .map { $0.key }
            .map { notes.myTicket.values[$0] }
            .reduce(1, *)
        
        return departures
    }
}
