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

//    func testPrintUsage() {
//        let stream = BufferedOutputByteStream()
//        let register = CommandRegistry(usage: "usage", overview: "overview")
//        register. parser.printUsage(on: stream)
//        let expectation = """
//        OVERVIEW: overview
//
//        USAGE: xctest usage
//
//        """
//        XCTAssertEqual(stream.bytes.asString, expectation)
//    }
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
