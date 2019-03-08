import XCTest

extension TestToolTests {
    static let __allTests = [
        ("testVersionCommand", testVersionCommand),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TestToolTests.__allTests),
    ]
}
#endif
