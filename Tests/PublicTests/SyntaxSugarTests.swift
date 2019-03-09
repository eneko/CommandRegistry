import XCTest
import CommandRegistry

final class SyntaxSugarTests: XCTestCase {

    func testSugarNoArguments() {
        var output: String?
        var registry = CommandRegistry(usage: "foo", overview: "bar")
        registry.on(command: "hello", overview: "Says hello") { params in
            output = params.first.flatMap { "Hello \($0)!" } ?? "Hello world!"
        }

        registry.run(arguments: ["hello"])
        XCTAssertEqual(output, "Hello world!")
    }

    func testSugarSingleArgument() {
        var output: String?
        var registry = CommandRegistry(usage: "foo", overview: "bar")
        registry.on(command: "hello", overview: "Says hello") { params in
            output = params.first.flatMap { "Hello \($0)!" } ?? "Hello world!"
        }

        registry.run(arguments: ["hello", "Bob"])
        XCTAssertEqual(output, "Hello Bob!")
    }

    func testSugarMultipleArguments() {
        var output: String?
        var registry = CommandRegistry(usage: "foo", overview: "bar")
        registry.on(command: "hello", overview: "Says hello") { params in
            output = params.first.flatMap { "Hello \($0)!" } ?? "Hello world!"
        }

        registry.run(arguments: ["hello", "1", "2", "3", "4", "5", "6"])
        XCTAssertEqual(output, "Hello 1!")
    }

    func testSugarMultipleCommands() {
        var output: String?
        var registry = CommandRegistry(usage: "foo", overview: "bar")
        registry.on(command: "foo") { params in
            output = "foo \(params.count)"
        }
        registry.on(command: "bar") { params in
            output = "bar \(params.count)"
        }
        registry.on(command: "baz") { params in
            output = "baz \(params.count)"
        }

        registry.run(arguments: ["foo"])
        XCTAssertEqual(output, "foo 0")

        registry.run(arguments: ["bar", "1", "2"])
        XCTAssertEqual(output, "bar 2")

        registry.run(arguments: ["baz", "tan", "go"])
        XCTAssertEqual(output, "baz 2")
    }

}
