import Foundation
import Utility
import Basic
import Logger

public struct CommandRegistry {

    private let parser: ArgumentParser
    private var commands: [Command] = []

    public var version: String?

    public init(usage: String, overview: String) {
        parser = ArgumentParser(usage: usage, overview: overview)
    }

    @discardableResult
    public mutating func register(command commandType: Command.Type) -> Command {
        let command = commandType.init(parser: parser)
        commands.append(command)
        return command
    }

    @discardableResult
    public mutating func register(subcommand commandType: Command.Type, parent: Command) -> Command {
        let subcommand = commandType.init(parser: parent.subparser)
        parent.subcommands.append(subcommand)
        return subcommand
    }

    public func run() {
        addVersionFlag()
        do {
            let parsedArguments = try parse()
            try process(arguments: parsedArguments)
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

    private func addVersionFlag() {
        if version != nil {
            _ = parser.add(option: "--version", kind: Bool.self)
        }
    }

    private func parse() throws -> ArgumentParser.Result {
        let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())
        return try parser.parse(arguments)
    }

    private func process(arguments: ArgumentParser.Result) throws {
        // Check for default option flags
        if let version = version, try arguments.get("--version") == true {
            Logger.standard.log(version)
            return
        }

        // Navigate subcommands to find the last subcommand entered (tool command subcommandA subcommandB...)
        var parser = self.parser
        var commands = self.commands
        var command: Command?
        while let commandName = arguments.subparser(parser), let match = commands.first(where: { $0.command == commandName }) {
            parser = match.subparser
            commands = match.subcommands
            command = match
        }

        // Execute command, if any, otherwise print usage
        if let command = command {
            try command.run(with: arguments)
        }
        else {
            parser.printUsage(on: stdoutStream)
        }
    }

}
