import ArgumentParser
import Day1
import Day2
import Day3
import Day4
import Day5
import Foundation

struct AdventOfCode2020 : ParsableCommand {
    static var configuration = CommandConfiguration (
        commandName: "aoc2020",
        abstract: "Puzzle solutions to Advent of Code 2020 by @RobJDavey",
        version: "2020.5.0",
        subcommands: [
            Day1.self,
            Day2.self,
            Day3.self,
            Day4.self,
            Day5.self,
        ]
    )
    
    func run() throws {
        Self.configuration.subcommands.forEach { subcommand in
            subcommand.main()
            print()
        }
    }
}

AdventOfCode2020.main()
