import ArgumentParser
import Foundation
import Shared

public class Bag {
    let color: String
    var contents: [Bag : Int] = [:]
    
    init(color: String) {
        self.color = color
    }
    
    var contentsTotal: Int {
        let totals = contents.map { (bag, quantity) in quantity + quantity * bag.contentsTotal }
        return totals.reduce(0, +)
    }
}

extension Bag : CustomStringConvertible, Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(color)
    }
    
    public static func == (lhs: Bag, rhs: Bag) -> Bool {
        return lhs.color == rhs.color
    }
    
    public var description: String {
        return "\(color) bag"
    }
}

extension Array where Element == Bag {
    mutating func findOrCreate(_ color: String) -> Element {
        guard let bag = first(where: { $0.color == color }) else {
            let bag = Bag(color: color)
            self.append(bag)
            return bag
        }
        
        return bag
    }
}

public typealias Bags = [Bag]

enum Day7Error : String, Error {
    case parseError = "Failed to parse the input text"
}

public struct Day7 : FileInputCommand {
    public static var configuration = CommandConfiguration (
        commandName: "day7",
        abstract: "Day 7: Handy Haversacks"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) throws -> Bags {
        return try Self.parse(rawInput.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    public func run(_ bags: Bags) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        guard let target = bags.first(where: { $0.color == "shiny gold" }) else { fatalError() }
        
        let answer1 = Self.part1(bags, target: target)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(bags, target: target)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ bags: Bags, target: Bag) -> Int {
        var result = Set<Bag>()
        guard let target = bags.first(where: { $0.color == "shiny gold" }) else { fatalError() }
        var targets = [target]
        
        while !targets.isEmpty {
            let contents = targets.removeFirst()
            let containers = bags.filter { $0.contents.keys.contains(contents) }
            for container in containers {
                result.insert(container)
                targets.append(container)
            }
        }
        
        return result.count
    }
    
    public static func part2(_ bags: Bags, target: Bag) -> Int {
        return target.contentsTotal
    }
    
    public static func parse(_ text: String) throws -> Bags {
        let lines = text.components(separatedBy: .newlines)
        
        var bags: Bags = []
        
        for line in lines {
            guard let colorRange = line.range(of: #"^\w+ \w+ bags"#, options: .regularExpression) else {
                throw Day7Error.parseError
            }
            
            let colorComponents = line[colorRange].components(separatedBy: .whitespaces)
            guard colorComponents.count == 3 else {
                throw Day7Error.parseError
            }
            
            let color = "\(colorComponents[0]) \(colorComponents[1])"
            let bag = bags.findOrCreate(color)
            var range: Range<String.Index>? = colorRange.upperBound..<line.endIndex
            
            repeat {
                range = line.range(of: #"(\d+ \w+ \w+ bags?)"#, options: .regularExpression, range: range)
                
                if let r = range {
                    let innerBagColorComponents = line[r].components(separatedBy: .whitespaces)
                    
                    guard innerBagColorComponents.count == 4 else {
                        throw Day7Error.parseError
                    }
                    
                    guard let innerBagQuantity = Int(innerBagColorComponents[0]) else {
                        throw Day7Error.parseError
                    }
                    
                    let innerBagColor = "\(innerBagColorComponents[1]) \(innerBagColorComponents[2])"
                    let innerBag = bags.findOrCreate(innerBagColor)
                    bag.contents[innerBag] = innerBagQuantity
                    range = r.upperBound..<line.endIndex
                }
            } while range != nil
        }
        
        return bags
    }
}
