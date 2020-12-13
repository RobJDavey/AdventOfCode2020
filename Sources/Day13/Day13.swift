import ArgumentParser
import Foundation
import Shared

public struct BusInfo {
    let departure: Int
    let timetable: [Bus?]
}

public struct Bus {
    let id: Int
}

extension Bus : CustomStringConvertible {
    init?(_ id: Int?) {
        guard let id = id else { return nil }
        self.init(id: id)
    }
    
    public var description: String { "Bus \(id)" }
}

extension Bus {
    var departureTimes: StrideTo<Int> {
        return stride(from: id, to: Int.max, by: id)
    }
}

public struct Day13 : FileInputCommand {
    public typealias InputType = BusInfo
    
    public static var configuration = CommandConfiguration (
        commandName: "day13",
        abstract: "Day 13: Shuttle Search"
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
        let lines = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: .newlines)
        assert(lines.count == 2)
        
        guard let departure = Int(lines[0]) else {
            fatalError()
        }
        
        let timetable = lines[1]
            .components(separatedBy: ",")
            .map { Int($0) }
            .map { Bus($0) }
        
        return BusInfo(departure: departure, timetable: timetable)
    }
    
    public func run(_ input: InputType) throws {
        print("--- \(Self.configuration.abstract) ---")
        
        let answer1 = Self.part1(input)
        print("Part 1: \(answer1)")

        let answer2 = Self.part2(input)
        print("Part 2: \(answer2)")
    }
    
    public static func part1(_ busInfo: InputType) -> Int {
        let match = busInfo.timetable
            .compactMap { $0 }
            .map { (id: $0.id, time: $0.departureTimes.first(where: { $0 >= busInfo.departure }) ?? Int.max) }
            .min { $0.time < $1.time }!
        
        let wait = match.time - busInfo.departure
        return wait * match.id
    }

    public static func part2(_ busInfo: InputType) -> Int {
        let ids = busInfo.timetable
            .map { $0?.id ?? 1 }
        
        var increment = ids.first!
        var index = 1
        var result = increment
        
        while index < ids.count {
            if (result + index) % ids[index] == 0 {
                increment *= ids[index]
                index += 1
            } else {
                result += increment
            }
        }
        
        return result
    }
}
