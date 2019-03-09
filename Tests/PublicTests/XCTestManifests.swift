import XCTest

extension CommandTests {
    static let __allTests = [
        ("testCommand", testCommand),
        ("testOverview", testOverview),
        ("testPrintCommandUsage", testPrintCommandUsage),
    ]
}

extension CommandWithArgumentTests {
    static let __allTests = [
        ("testHello", testHello),
    ]
}

extension SyntaxSugarTests {
    static let __allTests = [
        ("testSugarMultipleArguments", testSugarMultipleArguments),
        ("testSugarMultipleCommands", testSugarMultipleCommands),
        ("testSugarNoArguments", testSugarNoArguments),
        ("testSugarSingleArgument", testSugarSingleArgument),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CommandTests.__allTests),
        testCase(CommandWithArgumentTests.__allTests),
        testCase(SyntaxSugarTests.__allTests),
    ]
}
#endif
