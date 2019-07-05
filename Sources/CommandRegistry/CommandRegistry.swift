import Foundation
import SPMUtility
import Basic
import Logger

public struct CommandRegistry {

    let parser: ArgumentParser
    var commands: [Command] = []

    public var version: String?

    public init(usage: String, overview: String, toolname: String? = nil) {
        parser = ArgumentParser(commandName: toolname, usage: usage, overview: overview)
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

    public func run(arguments: [String]? = nil) {
        addVersionFlag()
        do {
            let arguments = arguments ?? Array(ProcessInfo.processInfo.arguments.dropFirst())
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

    private func addVersionFlag() {
        if version != nil {
            _ = parser.add(option: "--version", kind: Bool.self)
        }
    }

    func parse(arguments: [String]) throws -> ArgumentParser.Result {
        return try parser.parse(arguments)
    }

    func process(parsedArguments: ArgumentParser.Result) throws {
        // Check for default option flags
        if let version = version, try parsedArguments.get("--version") == true {
            Logger.standard.log(version)
            return
        }

        // Navigate subcommands to find the last subcommand entered (tool command subcommandA subcommandB...)
        var parser = self.parser
        var commands = self.commands
        var command: Command?
        while let commandName = parsedArguments.subparser(parser), let match = commands.first(where: { $0.command == commandName }) {
            parser = match.subparser
            commands = match.subcommands
            command = match
        }

        // Execute command, if any, otherwise print usage
        if let command = command {
            try command.run(with: parsedArguments)
        }
        else {
            parser.printUsage(on: stdoutStream)
        }
    }

}
