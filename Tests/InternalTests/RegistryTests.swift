import XCTest
import Basic
@testable import CommandRegistry
@testable import Utility

class RegistryTests: XCTestCase {

    func testParserUsage() {
        let register = CommandRegistry(usage: "usage", overview: "overview")
        XCTAssertEqual(register.parser.usage, "usage")
    }

    func testParserOverview() {
        let register = CommandRegistry(usage: "usage", overview: "overview")
        XCTAssertEqual(register.parser.overview, "overview")
    }

    func testPrintUsage() {
        let stream = BufferedOutputByteStream()
        let register = CommandRegistry(usage: "usage", overview: "overview", toolname: "mytool")
        register.parser.printUsage(on: stream)
        let expectation = """
        OVERVIEW: overview

        USAGE: mytool usage

        """
        XCTAssertEqual(stream.bytes.asString, expectation)
    }

}
