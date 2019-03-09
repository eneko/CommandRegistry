//
//  UpgradeCommandTests.swift
//  CommandRegistryTests
//
//  Created by Eneko Alonso on 3/9/19.
//

import XCTest
import CommandRegistry

class UpgradeCommandTests: XCTestCase {

    func testUpgrade() {
        var program = CommandRegistry(usage: "foo", overview: "bar")
        program.remoteURLForUpgrade = URL(string: "https://github.com/eneko/CommandRegistry")
        program.run(arguments: ["--upgrade"])
    }

}
