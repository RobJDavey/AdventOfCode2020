import ArgumentParser
import Day1
import Day2
import Day3
import Foundation

struct AdventOfCode2020 : ParsableCommand {
    static var configuration = CommandConfiguration (
        commandName: "aoc2020",
        abstract: "Puzzle solutions to Advent of Code 2020 by @RobJDavey",
        version: "2020.3.0",
        subcommands: [
            Day1.self,
            Day2.self,
            Day3.self,
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
