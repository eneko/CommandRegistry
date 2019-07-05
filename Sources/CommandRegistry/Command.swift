import Foundation
import SPMUtility
import Basic

public protocol Command: class {
    var command: String { get }
    var overview: String { get }
    var subparser: ArgumentParser { get }
    var subcommands: [Command] { get set }

    init(parser: ArgumentParser)
    func run(with arguments: ArgumentParser.Result) throws
}

extension Command {
    public func printUsage(on stream: OutputByteStream = stdoutStream) {
        subparser.printUsage(on: stream)
    }
}
