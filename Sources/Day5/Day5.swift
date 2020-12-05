import ArgumentParser
import Foundation
import Shared

let allRows = 0..<128
let allColumns = 0..<8

public enum BoardingPassKey : Character {
    case back = "B"
    case front = "F"
    case left = "L"
    case right = "R"
}

extension BoardingPassKey {
    var max: Int {
        switch self {
        case .front, .back:
            return allRows.upperBound
        case .left, .right:
            return allColumns.upperBound
        }
    }
}

extension Range where Bound == Int {
    func partition(by key: BoardingPassKey) -> Self {
        let midpoint = lowerBound + (count / 2)
        
        switch key {
        case .front, .left:
            return clamped(to: 0..<midpoint)
        case .back, .right:
            return clamped(to: midpoint..<key.max)
        }
    }
}

public enum Day5Error : String, Error {
    case unknownSeat = "Could not determine your seat"
}

public typealias BoardingPass = [BoardingPassKey]
public typealias Input = [BoardingPass]

public struct Day5 : FileInputCommand {
    public static var configuration = CommandConfiguration (
        commandName: "day5",
        abstract: "Day 5: Binary Boarding"
    )
    
    public init() {
    }
    
    @Argument(help: "The input to use")
    public var input: String?
    
    public func defaultInputFile() -> URL? {
        return Bundle.module.url(forResource: "input", withExtension: "txt")
    }
    
    public func convert(_ rawInput: String) -> Input {
        return rawInput
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
            .map { $0.compactMap(BoardingPassKey.init) }
    }
    
    public func run(_ input: Input) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = try Self.part2(input, maxSeatID: answer1)
        print("Part 2: \(answer2)")
    }
    
    public static func seatID(for boardingPass: BoardingPass) -> Int {
        var rows = allRows
        var columns = allColumns
        
        for key in boardingPass {
            switch key {
            case .front, .back:
                rows = rows.partition(by: key)
            case .left, .right:
                columns = columns.partition(by: key)
            }
        }
        
        let row = rows.lowerBound
        let column = columns.lowerBound
        return row * 8 + column
    }
    
    public static func part1(_ boardingPasses: Input) -> Int {
        var result = 0
        
        for boardingPass in boardingPasses {
            let id = seatID(for: boardingPass)
            result = max(result, id)
        }
        
        return result
    }
    
    public static func part2(_ boardingPasses: Input, maxSeatID: Int) throws -> Int {
        var seats = Set(0...maxSeatID)
        boardingPasses.forEach { seats.remove(seatID(for: $0)) }
        
        for seat in seats {
            if seats.contains(seat - 1) || seats.contains(seat + 1) {
                continue
            }
            
            return seat
        }
        
        throw Day5Error.unknownSeat
    }
}
