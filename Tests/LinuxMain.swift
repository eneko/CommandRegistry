import XCTest

import PublicTests
import InternalTests

var tests = [XCTestCaseEntry]()
tests += PublicTests.__allTests()
tests += InternalTests.__allTests()

XCTMain(tests)
