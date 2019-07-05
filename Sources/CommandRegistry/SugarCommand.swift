import Foundation
import SPMUtility
import Basic
import Logger

class SugarCommand: Command {
    let command: String
    let overview: String
    let subparser: ArgumentParser
    var subcommands: [Command] = []
    let handler: ([String]) throws -> Void
    let positionalArguments: PositionalArgument<[String]>

    init(parser: ArgumentParser, command: String, overview: String,
         handler: @escaping ([String]) throws -> Void) {
        self.command = command
        self.overview = overview
        self.handler = handler
        subparser = parser.add(subparser: command, overview: overview)
        positionalArguments = subparser.add(positional: "params", kind: [String].self,
                                            optional: true, usage: "Additional parameters")
    }

    required init(parser: ArgumentParser) {
        fatalError("Not supported")
    }

    func run(with arguments: ArgumentParser.Result) throws {
        try handler(arguments.get(positionalArguments) ?? [])
    }
}

extension CommandRegistry {
    public mutating func on(command: String, overview: String = "", handler: @escaping ([String]) throws -> Void) rethrows {
        let sugar = SugarCommand(parser: parser, command: command,
                                 overview: overview, handler: handler)
        commands.append(sugar)
    }
}
