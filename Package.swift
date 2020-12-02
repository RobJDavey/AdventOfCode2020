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
    ]
)
