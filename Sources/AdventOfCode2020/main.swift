import ArgumentParser
import Day1
import Day2
import Day3
import Day4
import Day5
import Day6
import Day7
import Day8
import Day9
import Day10
import Day11
import Day12
import Day13
import Day14
import Day15
import Day16
import Day17
import Foundation

struct AdventOfCode2020 : ParsableCommand {
    static var configuration = CommandConfiguration (
        commandName: "aoc2020",
        abstract: "Puzzle solutions to Advent of Code 2020 by @RobJDavey",
        version: "2020.17.0",
        subcommands: [
            Day1.self,
            Day2.self,
            Day3.self,
            Day4.self,
            Day5.self,
            Day6.self,
            Day7.self,
            Day8.self,
            Day9.self,
            Day10.self,
            Day11.self,
            Day12.self,
            Day13.self,
            Day14.self,
            Day15.self,
            Day16.self,
            Day17.self,
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
