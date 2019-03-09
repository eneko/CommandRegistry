//
//  TestUsage.swift
//  CommandRegistryTests
//
//  Created by Eneko Alonso on 3/9/19.
//

import XCTest
@testable import CommandRegistry
@testable import Utility

class UsageTests: XCTestCase {

    func testParserUsage() {
        let register = CommandRegistry(usage: "usage", overview: "overview")
        XCTAssertEqual(register.parser.usage, "usage")
    }

    func testParserOverview() {
        let register = CommandRegistry(usage: "usage", overview: "overview")
        XCTAssertEqual(register.parser.overview, "overview")
    }

}
