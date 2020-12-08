import ArgumentParser
import Foundation
import Shared

enum Day8Error : String, Error {
    case didNotTerminate = "The program did not terminate"
}

public enum Instruction {
    case acc(Int)
    case jmp(Int)
    case nop(Int)
}

extension Instruction {
    init?(_ text: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }
        
        let components = text.components(separatedBy: .whitespaces)
        guard components.count == 2, let argument = Int(components[1]) else {
            return nil
        }
        
        let operation = components[0]
        
        switch operation {
        case "acc":
            self = .acc(argument)
        case "jmp":
            self = .jmp(argument)
        case "nop":
            self = .nop(argument)
        default:
            return nil
        }
    }
}

extension Instruction {
    func run(instructionPointer ip: inout Int, accumulator a: inout Int) {
        switch self {
        case let .acc(value):
            ip += 1
            a += value
        case let .jmp(value):
            ip += value
        case .nop:
            ip += 1
        }
    }
}

public typealias Instructions = [Instruction]

public struct Day8 : FileInputCommand {
    public static var configuration = CommandConfiguration (
        commandName: "day8",
        abstract: "Day 8: Handheld Halting"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> Instructions {
        return Self.parse(rawInput)
    }
    
    public static func parse(_ text: String) -> Instructions {
        return text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .compactMap(Instruction.init)
    }
    
    public func run(_ instructions: Instructions) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(instructions)
        print("Part 1: \(answer1)")

        let answer2 = try Self.part2(instructions)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ instructions: Instructions) -> Int {
        let (accumulator, _) = run(instructions: instructions)
        return accumulator
    }
    
    public static func part2(_ instructions: Instructions) throws -> Int {
        for (index, instruction) in instructions.enumerated() {
            let replacement: Instruction
            
            switch instruction {
            case .acc(_):
                continue
            case let .jmp(value):
                replacement = .nop(value)
            case let .nop(value):
                replacement = .jmp(value)
            }
            
            var copy = instructions
            copy[index] = replacement
            
            let (accumulator, terminated) = run(instructions: copy)
            guard !terminated else {
                return accumulator
            }
        }
        
        throw Day8Error.didNotTerminate
    }
    
    public static func run(instructions: Instructions) -> (accumulator: Int, terminated: Bool) {
        var instructionPointer = 0
        var accumulator = 0
        var executedInstructions = Set<Int>()
        
        repeat {
            guard !executedInstructions.contains(instructionPointer) else {
                return (accumulator, false)
            }
            
            executedInstructions.insert(instructionPointer)
            
            guard instructionPointer < instructions.endIndex else {
                return (accumulator, true)
            }
            
            let instruction = instructions[instructionPointer]
            instruction.run(instructionPointer: &instructionPointer, accumulator: &accumulator)
        } while true
    }
}
