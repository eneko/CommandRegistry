import XCTest
@testable import CommandRegistry
@testable import Utility

class FooCommand: Command {
    let command = "foo"
    let overview = "foo"
    required init(parser: ArgumentParser) {
        parser.add(subparser: command, overview: overview)
    }
    func run(with arguments: ArgumentParser.Result) throws {
        //
    }
}

final class CommandRegistryTests: XCTestCase {
    func testFooCommand() {
        let parser = ArgumentParser(usage: "usage", overview: "overview")
        let instance = FooCommand(parser: parser)
        XCTAssertEqual(instance.command, "foo")
        XCTAssertEqual(instance.overview, "foo")
    }

    func testRegister() {
        let register = CommandRegistry(usage: "usage", overview: "overview")
        XCTAssertEqual(register.parser.usage, "usage")
        XCTAssertEqual(register.parser.overview, "overview")
    }

}
