import XCTest

extension CommandRegistryTests {
    static let __allTests = [
        ("testFooCommand", testFooCommand),
        ("testRegister", testRegister),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CommandRegistryTests.__allTests),
    ]
}
#endif
