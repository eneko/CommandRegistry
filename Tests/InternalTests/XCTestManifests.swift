import XCTest

extension RegistryTests {
    static let __allTests = [
        ("testParserOverview", testParserOverview),
        ("testParserUsage", testParserUsage),
        ("testPrintUsage", testPrintUsage),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RegistryTests.__allTests),
    ]
}
#endif
