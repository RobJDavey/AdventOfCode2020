import ArgumentParser
import Foundation
import Shared

public enum PassportField : String, Hashable {
    case birthYear = "byr"
    case issueYear = "iyr"
    case expirationYear = "eyr"
    case height = "hgt"
    case hairColor = "hcl"
    case eyeColor = "ecl"
    case passportID = "pid"
    case countryID = "cid"
}

public typealias Passport = [PassportField : String]
public typealias Passports = [Passport]

enum EyeColor: String {
    case amber = "amb"
    case blue = "blu"
    case brown = "brn"
    case grey = "gry"
    case green = "grn"
    case hazel = "hzl"
    case other = "oth"
}

enum HeightUnit : String  {
    case centimeters = "cm"
    case inches = "in"
}

extension HeightUnit {
    func isValid(_ height: Int) -> Bool {
        switch self {
        case .centimeters:
            return (150...193).contains(height)
        case .inches:
            return (59...76).contains(height)
        }
    }
}

extension PassportField {
    static var mandatoryFields: Set<PassportField> = [.birthYear, .issueYear, .expirationYear, .height, .hairColor, .eyeColor, .passportID]
    
    func isValid(_ value: String) -> Bool {
        switch self {
        case .birthYear:
            guard let i = Int(value), (1920...2002).contains(i) else { return false }
            return true
        case .issueYear:
            guard let i = Int(value), (2010...2020).contains(i) else { return false }
            return true
        case .expirationYear:
            guard let i = Int(value), (2020...2030).contains(i) else { return false }
            return true
        case .height:
            guard let _ = value.range(of: #"^(\d+)(in|cm)$"#, options: .regularExpression),
               let heightRange = value.range(of: #"^(\d+)"#, options: .regularExpression),
               let unitRange = value.range(of: #"(in|cm)$"#, options: .regularExpression),
               let height = Int(value[heightRange]),
               let unit = HeightUnit(rawValue: String(value[unitRange])),
               unit.isValid(height)
            else {
                return false
            }
            
            return true
        case .hairColor:
            guard let _ = value.range(of: #"^#[0-9a-f]{6}$"#, options: .regularExpression) else { return false }
            return true
        case .eyeColor:
            guard let _ = EyeColor(rawValue: value) else { return false }
            return true
        case .passportID:
            return value.range(of: #"^\d{9}$"#, options: .regularExpression) != nil
        case .countryID:
            return true
        }
    }
}

public struct Day4 : FileInputCommand  {
    public static var configuration = CommandConfiguration (
        commandName: "day4",
        abstract: "Day 4: Passport Processing"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> Passports {
        return Self.parse(rawInput)
    }
    
    public func run(_ input: Passports) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ passports: Passports) -> Int {
        return passports
            .filter { PassportField.mandatoryFields.subtracting($0.keys).isEmpty }
            .count
    }
    
    public static func part2(_ passports: Passports) -> Int {
        return passports
            .filter { PassportField.mandatoryFields.subtracting($0.keys).isEmpty }
            .map { $0.map { $0.key.isValid($0.value) }.reduce(true, { $0 && $1 }) }
            .filter { $0 }
            .count
    }
    
    static func parse(field text: String) -> (PassportField, String) {
        let components = text.components(separatedBy: ":")
        assert(components.count == 2)
        guard let key = PassportField(rawValue: components[0]) else { fatalError() }
        return (key, components[1])
    }

    static func parse(record text: String) -> Passport {
        let fields = text.components(separatedBy: .whitespacesAndNewlines)
            .map(parse(field:))
        
        return Dictionary(uniqueKeysWithValues: fields)
    }

    static func parse(_ text: String) -> [Passport] {
        return text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n\n")
            .map(parse(record:))
    }
}
