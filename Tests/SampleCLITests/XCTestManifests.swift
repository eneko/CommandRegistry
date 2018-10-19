import XCTest

extension SampleCLITests {
    static let __allTests = [
        ("testHello", testHello),
        ("testHelloSugar", testHelloSugar),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SampleCLITests.__allTests),
    ]
}
#endif
