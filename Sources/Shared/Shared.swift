import ArgumentParser
import Foundation

enum FileInputCommandError : String, Error {
    case missingDefault = "Could not find the default input"
    case unableToLoadInput = "Could not load the input"
}

public protocol InputCommand : ParsableCommand {
    associatedtype InputType
    
    func run(_ input: InputType) throws
}

public protocol StringInputCommand : InputCommand {
    var input: String? { get }
    
    func defaultInput() -> String
    func convert(_ rawInput: String) throws -> InputType
}

public protocol FileInputCommand : InputCommand {
    var input: String? { get }
    
    func defaultInputFile() -> URL?
    func convert(_ rawInput: String) throws -> InputType
}

public extension StringInputCommand {
    func run() throws {
        let rawInput: String
        
        if let input = input {
            rawInput = input
        } else {
            rawInput = defaultInput()
        }
        
        let converted = try convert(rawInput)
        return try run(converted)
    }
}

public extension FileInputCommand {
    func run() throws {
        let url: URL

        if let inputFilePath = input {
            url = URL(fileURLWithPath: inputFilePath)
        } else {
            guard let bundleURL = defaultInputFile() else {
                throw FileInputCommandError.missingDefault
            }

            url = bundleURL
        }
        
        guard let text = try? String(contentsOf: url) else {
            throw FileInputCommandError.missingDefault
        }
        
        let rawInput = try convert(text)
        try run(rawInput)
    }
}
