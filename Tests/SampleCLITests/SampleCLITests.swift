import XCTest
import Utility
import CommandRegistry

var output = [String: String]()

class HelloCommand: Command {
    let command = "hello"
    let overview = "Says hello"
    var key: PositionalArgument<String>
    required init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        key = subparser.add(positional: "key", kind: String.self)
    }
    func run(with arguments: ArgumentParser.Result) throws {
        if let key = arguments.get(self.key) {
            output[key] = "Hello World!"
        }
    }
}

final class SampleCLITests: XCTestCase {

    func testHello() {
        let key = UUID().uuidString
        var registry = CommandRegistry(usage: "foo", overview: "bar")
        registry.register(command: HelloCommand.self)
        registry.run(arguments: ["foo", "hello", key])
        XCTAssertEqual(output[key], "Hello World!")
    }

    func testHelloSugar() {
        let key = UUID().uuidString
        var registry = CommandRegistry(usage: "foo", overview: "bar")
        registry.on(command: "hello", overview: "Says hello") {
            output[key] = "Hello World!"
        }
        registry.run(arguments: ["foo", "hello"])
        XCTAssertEqual(output[key], "Hello World!")
    }

}
