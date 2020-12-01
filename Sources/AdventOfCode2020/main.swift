import ArgumentParser
import Foundation

struct AdventOfCode2020 : ParsableCommand {
    static var configuration = CommandConfiguration (
        commandName: "aoc2020",
        abstract: "Puzzle solutions to Advent of Code 2020 by @RobJDavey",
        version: "2020.0.0",
        subcommands: [
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
