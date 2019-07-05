import XCTest
import Basic
import CommandRegistry

final class CommandTests: XCTestCase {
    func testCommand() {
        let parser = ArgumentParser(usage: "usage", overview: "overview")
        let instance = FooCommand(parser: parser)
        XCTAssertEqual(instance.command, "foo")
    }

    func testOverview() {
        let parser = ArgumentParser(usage: "usage", overview: "overview")
        let instance = FooCommand(parser: parser)
        XCTAssertEqual(instance.overview, "foo")
    }

    func testPrintCommandUsage() {
        let stream = BufferedOutputByteStream()
        let parser = ArgumentParser(usage: "usage", overview: "overview")
        let instance = FooCommand(parser: parser)
        instance.printUsage(on: stream)
        let expectation = """
        OVERVIEW: foo

        """
        XCTAssertEqual(stream.bytes.description, expectation)
    }
}

class FooCommand: Command {
    let command = "foo"
    let overview = "foo"
    var subparser: ArgumentParser
    var subcommands: [Command] = []

    required init(parser: ArgumentParser) {
        subparser = parser.add(subparser: command, overview: overview)
    }
    func run(with arguments: ArgumentParser.Result) throws {
        //
    }
}
