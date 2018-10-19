import Foundation
import Utility
import Basic
import Logger

public struct CommandRegistry {

    let parser: ArgumentParser
    var commands: [Command] = []

    public init(usage: String, overview: String) {
        parser = ArgumentParser(usage: usage, overview: overview)
    }

    public mutating func register(command: Command.Type) {
        commands.append(command.init(parser: parser))
    }

    public func run(arguments: [String] = ProcessInfo.processInfo.arguments) {
        do {
            let parsedArguments = try parse(arguments: arguments)
            try process(parsedArguments: parsedArguments)
        }
        catch let error as ArgumentParserError {
            Logger.error.log(error.description)
        }
        catch DecodingError.keyNotFound(_, let context) {
            Logger.error.log(context.debugDescription)
            Logger.error.log(context.codingPath.description)
        }
        catch let error {
            Logger.error.log(error.localizedDescription)
        }
    }

    func parse(arguments: [String]) throws -> ArgumentParser.Result {
        let arguments = Array(arguments.dropFirst())
        return try parser.parse(arguments)
    }

    func process(parsedArguments: ArgumentParser.Result) throws {
        guard let subparser = parsedArguments.subparser(parser),
            let command = commands.first(where: { $0.command == subparser }) else {
                parser.printUsage(on: stdoutStream)
                return
        }
        try command.run(with: parsedArguments)
    }

}

// MARK: Sugar syntax

struct BasicCommand: Command {
    let command: String
    let overview: String
    let handler: () throws -> Void
    init(command: String, overview: String, handler: @escaping () throws -> Void) {
        self.command = command
        self.overview = overview
        self.handler = handler
    }
    init(parser: ArgumentParser) {
        fatalError("Not supported")
    }
    func run(with arguments: ArgumentParser.Result) throws {
        try handler()
    }
}

extension CommandRegistry {
    public mutating func on(command: String, overview: String = "", handler: @escaping () throws -> Void) rethrows {
        commands.append(BasicCommand(command: command, overview: overview, handler: handler))
        parser.add(subparser: command, overview: overview)
    }
}
