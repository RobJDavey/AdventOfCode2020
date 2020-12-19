// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Advent of Code 2020",
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", .upToNextMinor(from: "0.0.1")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.3.0")),
    ],
    targets: [
        .target(
            name: "AdventOfCode2020",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Day1",
                "Day2",
                "Day3",
                "Day4",
                "Day5",
                "Day6",
                "Day7",
                "Day8",
                "Day9",
                "Day10",
                "Day11",
                "Day12",
                "Day13",
                "Day14",
                "Day15",
                "Day16",
                "Day17",
                "Day18",
            ]
        ),
        .target(
            name: "Shared",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "Day1",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day1Tests",
            dependencies: [
                "Day1",
            ]
        ),
        .target(
            name: "Day2",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day2Tests",
            dependencies: [
                "Day2",
            ]
        ),
        .target(
            name: "Day3",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day3Tests",
            dependencies: [
                "Day3",
            ]
        ),
        .target(
            name: "Day4",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day4Tests",
            dependencies: [
                "Day4",
            ]
        ),
        .target(
            name: "Day5",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day5Tests",
            dependencies: [
                "Day5",
            ]
        ),
        .target(
            name: "Day6",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day6Tests",
            dependencies: [
                "Day6",
            ]
        ),
        .target(
            name: "Day7",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day7Tests",
            dependencies: [
                "Day7",
            ]
        ),
        .target(
            name: "Day8",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day8Tests",
            dependencies: [
                "Day8",
            ]
        ),
        .target(
            name: "Day9",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day9Tests",
            dependencies: [
                "Day9",
            ]
        ),
        .target(
            name: "Day10",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day10Tests",
            dependencies: [
                "Day10",
            ]
        ),
        .target(
            name: "Day11",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day11Tests",
            dependencies: [
                "Day11",
            ]
        ),
        .target(
            name: "Day12",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day12Tests",
            dependencies: [
                "Day12",
            ]
        ),
        .target(
            name: "Day13",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day13Tests",
            dependencies: [
                "Day13",
            ]
        ),
        .target(
            name: "Day14",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day14Tests",
            dependencies: [
                "Day14",
            ]
        ),
        .target(
            name: "Day15",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day15Tests",
            dependencies: [
                "Day15",
            ]
        ),
        .target(
            name: "Day16",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day16Tests",
            dependencies: [
                "Day16",
            ]
        ),
        .target(
            name: "Day17",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day17Tests",
            dependencies: [
                "Day17",
            ]
        ),
        .target(
            name: "Day18",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "Shared",
            ],
            resources: [
                .copy("input.txt"),
            ]
        ),
        .testTarget(
            name: "Day18Tests",
            dependencies: [
                "Day18",
            ]
        ),
    ]
)
