import Foundation
import Utility
import Basic

public protocol Command {
    var command: String { get }
    var overview: String { get }

    init(parser: ArgumentParser)
    func run(with arguments: ArgumentParser.Result) throws
}
