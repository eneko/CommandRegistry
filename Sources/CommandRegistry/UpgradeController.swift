//
//  UpgradeController.swift
//  CommandRegistry
//
//  Created by Eneko Alonso on 3/9/19.
//

import Foundation
import Basic

final class UpgradeController {

    let session: String
    let directory: String

    init() {
        session = UUID().uuidString
        directory = ".\(session)"
    }

    func upgradeToLatestRelease(repoURL: URL) throws {
        try execute(command: "mkdir", directory)
        try execute(command: "git", "clone", repoURL.absoluteString, directory)
    }

    @discardableResult
    private func execute(command: String...) throws -> ProcessResult {
        let process = Basic.Process(arguments: command, redirectOutput: false)
        try process.launch()
        return try process.waitUntilExit()
    }

}
