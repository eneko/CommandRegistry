import XCTest

import CommandRegistryTests
import SampleCLITests

var tests = [XCTestCaseEntry]()
tests += CommandRegistryTests.__allTests()
tests += SampleCLITests.__allTests()

XCTMain(tests)
