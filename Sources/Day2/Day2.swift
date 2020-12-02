import ArgumentParser
import Foundation
import Shared

public struct Day2 : FileInputCommand {
    public static var configuration = CommandConfiguration (
        commandName: "day2",
        abstract: "Day 2: Password Philosophy"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> [PasswordPolicy] {
        return rawInput.components(separatedBy: .newlines).compactMap { PasswordPolicy($0) }
    }
    
    public func run(_ input: [PasswordPolicy]) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ policies: [PasswordPolicy]) -> Int {
        return run(Part1(), policies)
    }
    
    public static func part2(_ policies: [PasswordPolicy]) -> Int {
        return run(Part2(), policies)
    }
    
    static func run(_ validator: PasswordValidator, _ policies: [PasswordPolicy]) -> Int {
        return policies.map { validator.isValid($0) }.filter { $0 }.count
    }
}

public struct PasswordPolicy {
    let lowerBound: Int
    let upperBound: Int
    let character: Character
    let password: String
    
    init?(_ text: String) {
        let charset = CharacterSet(charactersIn: " :")
        let parts = text.components(separatedBy: charset).filter { !$0.isEmpty }
        
        guard parts.count == 3, let character = parts[1].first else {
            return nil
        }
        
        let bounds = parts[0].components(separatedBy: "-")
        assert(bounds.count == 2)
        
        guard let lower = Int(bounds[0]), let upper = Int(bounds[1]) else {
            return nil
        }
        
        self.lowerBound = lower
        self.upperBound = upper
        self.character = character
        self.password = parts[2]
    }
}

public protocol PasswordValidator {
    func isValid(_ policy: PasswordPolicy) -> Bool
}

public struct Part1 : PasswordValidator {
    public func isValid(_ policy: PasswordPolicy) -> Bool {
        let count = policy.password.filter { $0 == policy.character }.count
        return policy.lowerBound <= count && count <= policy.upperBound
    }
}

public struct Part2 : PasswordValidator {
    public func isValid(_ policy: PasswordPolicy) -> Bool {
        let password = policy.password
        let lowerIndex = password.index(password.startIndex, offsetBy: policy.lowerBound - 1)
        let upperIndex = password.index(password.startIndex, offsetBy: policy.upperBound - 1)
        let lowerCharacter = password[lowerIndex]
        let upperCharacter = password[upperIndex]
        let lower = lowerCharacter == policy.character
        let upper = upperCharacter == policy.character
        return (lower && !upper) || (upper && !lower)
    }
}
