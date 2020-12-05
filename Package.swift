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
    ]
)
