import XCTest
import CommandRegistry

var output = [String: String]()

class HelloCommand: Command {
    let command = "hello"
    let overview = "Says hello"
    let subparser: ArgumentParser
    var subcommands: [Command] = []

    var params: PositionalArgument<[String]>

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
        params = subparser.add(positional: "params", kind: [String].self, optional: true)
    }
    func run(with arguments: ArgumentParser.Result) throws {
        let params: [String] = arguments.get(self.params) ?? []
        if let key = params.first {
            output[key] = "Hello World!"
        }
    }
}

final class SampleCLITests: XCTestCase {

    func testHello() {
        let key = UUID().uuidString
        var registry = CommandRegistry(usage: "foo", overview: "bar")
        registry.register(command: HelloCommand.self)
        registry.run(arguments: ["hello", key])
        XCTAssertEqual(output[key], "Hello World!")
    }

    func testHelloSugar() {
        var output: String?
        var registry = CommandRegistry(usage: "foo", overview: "bar")
        registry.on(command: "hello", overview: "Says hello") { params in
            output = params.first.flatMap { "Hello \($0)!" } ?? "Hello world!"
        }

        registry.run(arguments: ["hello"])
        XCTAssertEqual(output, "Hello world!")
        registry.run(arguments: ["hello", "Bob"])
        XCTAssertEqual(output, "Hello Bob!")
    }

}
